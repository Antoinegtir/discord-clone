import 'package:flutter/material.dart';

final List<Map<String, dynamic>> settings = <Map<String, dynamic>>[
  <String, dynamic>{'button': 'Obtain Nitro', 'icon': Icons.discord},
  <String, dynamic>{'button': 'Account', 'icon': Icons.account_box_rounded},
  <String, dynamic>{'button': 'Profils', 'icon': Icons.edit},
  <String, dynamic>{
    'button': 'Security & Confidentilality',
    'icon': Icons.shield_moon_sharp
  },
  <String, dynamic>{'button': 'Family center', 'icon': Icons.people},
  <String, dynamic>{
    'button': 'Authorization Application',
    'icon': Icons.key_rounded
  },
];

final List<Map<String, dynamic>> status = <Map<String, dynamic>>[
  <String, dynamic>{
    'text': 'Online',
    'onPressed': () {},
    'color': Colors.green
  },
  <String, dynamic>{
    'text': 'Inactive',
    'onPressed': () {},
    'color': Colors.orange
  },
  <String, dynamic>{
    'text': 'Do not disturb',
    'onPressed': () {},
    'color': Colors.red
  },
  <String, dynamic>{
    'text': 'Invisible',
    'onPressed': () {},
    'color': Colors.grey
  },
];

final List<Map<String, dynamic>> account = <Map<String, dynamic>>[
  <String, dynamic>{'text': 'User Name'},
  <String, dynamic>{'text': 'Display Name'},
  <String, dynamic>{'text': 'E-mail'},
  <String, dynamic>{'text': 'Phone'},
  <String, dynamic>{'text': 'Password'},
];
