let darkMode = false;

function openBillingMenu() {
    document.getElementById('billingMenu').classList.remove('hidden');
    fetchNui('getInvoices', { status: 'open' }, function(invoices) {
        displayInvoices('openInvoicesList', invoices);
    });
    fetchNui('getInvoices', { status: 'paid' }, function(invoices) {
        displayInvoices('paidInvoicesList', invoices);
    });
    fetchNui('getInvoices', { status: 'sent' }, function(invoices) {
        displayInvoices('sentInvoicesList', invoices);
    });
}

function closeBillingMenu() {
    document.getElementById('billingMenu').classList.add('hidden');
    fetchNui('closeBillingMenu');
}

function openTab(tabName) {
    const tabContents = document.getElementsByClassName('tab-content');
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].classList.remove('active');
    }
    document.getElementById(tabName).classList.add('active');
    
    const tabButtons = document.getElementsByClassName('tab-button');
    for (let i = 0; i < tabButtons.length; i++) {
        tabButtons[i].classList.remove('active');
    }
    event.currentTarget.classList.add('active');
}

function displayInvoices(listId, invoices) {
    const list = document.getElementById(listId);
    list.innerHTML = '';
    
    invoices.forEach(invoice => {
        const invoiceElement = document.createElement('div');
        invoiceElement.className = 'invoice';
        invoiceElement.innerHTML = `
            <div class="invoice-details">
                <p><strong>Amount:</strong> $${invoice.amount}</p>
                <p><strong>Description:</strong> ${invoice.description}</p>
            </div>
            ${listId === 'openInvoicesList' ? `<button onclick="payInvoice(${invoice.id})">Pay</button>` : ''}
        `;
        list.appendChild(invoiceElement);
    });
}

function sendInvoice() {
    const receiverId = document.getElementById('receiverId').value;
    const amount = document.getElementById('amount').value;
    const description = document.getElementById('description').value;
    
    if (receiverId && amount && description) {
        fetchNui('sendInvoice', {
            receiverId: receiverId,
            amount: amount,
            description: description
        }, function(response) {
            alert('Invoice sent successfully.');
            document.getElementById('receiverId').value = '';
            document.getElementById('amount').value = '';
            document.getElementById('description').value = '';
        });
    } else {
        alert('Please fill in all fields.');
    }
}

function payInvoice(invoiceId) {
    fetchNui('payInvoice', { invoiceId: invoiceId }, function(response) {
        alert('Invoice paid successfully.');
        fetchNui('getInvoices', { status: 'open' }, function(invoices) {
            displayInvoices('openInvoicesList', invoices);
        });
    });
}

function fetchNui(eventName, data, cb) {
    fetch(`https://${GetParentResourceName()}/${eventName}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).then(resp => resp.json()).then(resp => cb(resp));
}

window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'openBillingMenu') {
        document.getElementById('logo').src = data.logoPath;
        darkMode = data.darkMode.enabled;
        if (darkMode) {
            document.body.style.backgroundColor = data.darkMode.backgroundColor;
            document.body.style.color = data.darkMode.textColor;
            document.querySelector('.header').style.backgroundColor = data.darkMode.headerColor;
        }
        openBillingMenu();
    } else if (data.action === 'closeBillingMenu') {
        closeBillingMenu();
    }
});