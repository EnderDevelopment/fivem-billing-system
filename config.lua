Config = {}

-- Keybind for opening the billing menu
Config.Keybind = 'F7'

-- Logo path for the billing menu
Config.LogoPath = 'logo.png'

-- Job-specific invoicing
Config.Jobs = {
    ['bennys'] = {
        label = 'Benny's',
        canInvoice = true
    },
    ['hayesautos'] = {
        label = 'Hayes Autos',
        canInvoice = true
    },
    ['vanilla'] = {
        label = 'Vanilla Unicorn',
        canInvoice = true
    },
    ['police'] = {
        label = 'Police/Law Enforcement',
        canInvoice = true
    }
}

-- Dark mode settings
Config.DarkMode = {
    enabled = true,
    backgroundColor = '#1a1a1a',
    textColor = '#ffffff',
    headerColor = '#333333'
}