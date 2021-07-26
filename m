Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9EC3D52C3
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhGZEeY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 00:34:24 -0400
Received: from mail-eopbgr1320139.outbound.protection.outlook.com ([40.107.132.139]:62144
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229711AbhGZEeD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 00:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcKMcwiV1VJ9OlLi/ymWb6kAIGoNWUbCZ985PUPA+JakqcS23EtVfSlgyGD+OXzyEaW1Z+BPOGVfjQHVYtkioRaMq8/IgM7ltLlgy6vkLc7bPQ3rWUcrRk9YAbO6gR2m3v4lhvuI4y6KTuUx8m4yB95/G722YuteJpJrHFLAPWhRsD5dDakmIFIu3uuZudT555teEkjflLkbtMuYRCiF4xhMDEEAXN6gKEDF7liWF4VVk6jfGOXpEpE/EjL6wvOK5XtJIjimH7ERio0AwklA3MLlWTgKJMYDVlTTglpe3SVJ1q/uAodjbXaUFBF11aPXIMj9xUkaKE2uc7q6rBytoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck1llJqnYuVluiYjscZ8CqS8e7DQHKJpNpYgW6JCa0U=;
 b=hDX25f/OGibPNTTmZtspnwEehNbHuOAhFpgsuD7sXscIPnzd4RlpXeFXUUgaShstOHz5I4P1wUY1XX4CIVHfkp64odw/dNyiJqcrvI2Bn2gDt516tdI7ZHBW1HHeL8jZwwk2PFs5k/ZT7pf3KyUBDBCq3cefd1bFtMiAp5jihVwwJKaC6Kd1kURbJNlsq33gYOj3PsJrOdoUtG3hdJR0JW11Agc+neGdGwQhXWVHA482zO3WwbLAPti33tkxqvQf4Wriugphqn+J5xQ6gVMA7obO350o9hTIN20YpF1YMvsICTN2hPaamMym3BmMprJ448609YoleaR+71ht8iee1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck1llJqnYuVluiYjscZ8CqS8e7DQHKJpNpYgW6JCa0U=;
 b=OyOCUDS5krzujWopGLobvXRFs6DadCa7xZUdsoBnoZBYOrgqM5XbABbnO3OS1yBHm6Chfwz5liE+f6QtgBCnf7rD6JhRfpiLnjieWE/GN7CEK4f4SpTB5Gmg+KqGO0iRKtDtTiOxo4IJTZilNUBBLvdeXns/CmH9ACk8Q0K5aackbeM9B0WKG9mZd4biGvx6ioXrd071ZhoKDACDmWZ1c7gjl5VszPHGlu55D83f7/NnKnUfQ4eSq5Hi1qf6836TRaMx56AwQYHba7lvkcbzasMQZIiFrRSXeRHW2N1vpXHXmg6CvZZO5w0O6rfcexdq2555WWDvQoGMtrRH60vBAw==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2865.apcprd06.prod.outlook.com (2603:1096:203:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 05:14:09 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 05:14:09 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4D//9OwgIAAqykA//+IDYCAAJI6gIAH2oiA//+aeoAAY7A+AAAQZVwAAIhAMYA=
Date:   Mon, 26 Jul 2021 05:14:09 +0000
Message-ID: <80C715D4-5B8A-4FC9-AD60-106F682DC929@aspeedtech.com>
References: <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
 <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
 <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
 <4BC9AEF6-31EA-4EDA-BCB2-7E4D44B6D5D2@aspeedtech.com>
 <20210721124859.clv6qlitbyomdz6s@pengutronix.de>
 <7F794DD8-0FC6-491D-B071-CAD6C216E044@aspeedtech.com>
 <20210723201250.x4ki5ackfznmn4aw@pengutronix.de>
In-Reply-To: <20210723201250.x4ki5ackfznmn4aw@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6111065-69c0-4fa3-f67e-08d94ff43317
x-ms-traffictypediagnostic: HK0PR06MB2865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB28654809B281344CB5E1716B8BE89@HK0PR06MB2865.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCqKvQIghk7zq1WumuUB7yM2HNdT9UtZErw37tGHjN+kOft0K2NIC8UebYihpG4oGN7Oc0t81aT5NNGYV7gv3xiusXqnZ1mewcPQRRYFXABxGK+3Mp4gLHe3lTP5+O3cPunnIQZ0KTIvRSpYUftXN3wLQoIDvoahXHpAp44/8QGa0sC5pvPkoTz5+IFJC8cxN42kEPcuCL+w2dnZpDuYueBDlFBmy8AHLJ6T25M74SxcXUC4Kk+9WCSoZbr9hkBY7hXMHmW3aQ2Ln4V7W6Z9lX9I4izwoq2VE0u1A3g51krzcck+mDJKx6tgb/5DwZXPeJFYfvOfpiviDHdUDwKMxkCeKm/PzidZea00vv/SW2nKMqa9SiKl2M9bxKMvdHjw5napZbkD4eU+du9iyB6AZoENimfDRLczVuda7+Lb03e07dbVRHoMHlzDirS5v10uu96vJx0BqZ2GYgaPHA5xtJK9BZrHUn13eJR1hh+/jV89ir+VhRcoE2gHZ2ryq2ENeHDLIIp3JSRodYyw1AIwTCLcoZHGBluSvkCAJiJo4E9kPrRHigEQ5E0k0tFSY1tn8PoiNjDE8qEFY5CAI+GJRTtm+UTh6fjFupVzSTSAUf4biS9PvRgAfoEj0B3GHrLDHe9yx2oOd6c7SmjM0yTYoH7eVquLSKHvVnQbGMd1w3Di7u+HI2WITLmjR4CTBmNBNtVPl+gxD9X5p2tDgu1GYa/20H930pwpr3otJU7v2wc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(346002)(136003)(376002)(366004)(64756008)(2616005)(66946007)(66476007)(76116006)(91956017)(38100700002)(54906003)(8936002)(122000001)(83380400001)(186003)(7416002)(6916009)(66574015)(66556008)(33656002)(6486002)(4326008)(86362001)(26005)(36756003)(5660300002)(107886003)(8676002)(71200400001)(2906002)(6506007)(53546011)(6512007)(508600001)(66446008)(316002)(55236004)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXNHU1JWeGVMVjh1Yit2L09OYy9scGdiSTZCT2dZMTNydnJFSXNFanlZMVlx?=
 =?utf-8?B?aDljU1EwUHVKajZWV2VEc2txT2hqMGFldUJESnFJcVY1K3RoVmJNZ3dxWVpn?=
 =?utf-8?B?K291bWcrbnJ2VEdTRnZ4ZDJLYlM3Um9hc1Q5RlVmK1FLN1FxMUhtc081Z28z?=
 =?utf-8?B?SmFCTDQzQVM4V0xsYzZOKzBpVDV3ZXNqNmpxcnNsMlBtYUQwQWNkdHdNcnUw?=
 =?utf-8?B?Y0Z5MjZuaGFpUFlUYmtMVkNxdU9RclBSODRKUmhiUSswMXB1QXFwRlcyMWFr?=
 =?utf-8?B?T2dNQ2Y5NzUyQXk4N1ZXdnJGbEJFT3VmZUJqNlU1VTBXdzNmc1pVSXpqbVEx?=
 =?utf-8?B?OGZrWHdsdjNRblhubnZPK3ExSmlsVlV3ZnZTVnk3TXNnTnc2OG5mMEt3SERU?=
 =?utf-8?B?SE1LOGNTREN5RDdjZ0JEVzNzdjNyczVZWlhOdkZoby9TWk1tZFdjR29qeTkr?=
 =?utf-8?B?OUhtV1NCVUlhUks5RGFTSSsxOWJzQU12ZituV2taUVFkQVBpaG5CS09Nai9V?=
 =?utf-8?B?WXlJcCtpeC82MUFFeTgzbWw3N1kybWFsL3N3b3BUYjR4YnBLTXIxT3lDTUpn?=
 =?utf-8?B?VzVnWWVSaHZqeGdrS1QwVzJLZkgxOWhodnhPcTZ6YVdGYnY1QSt4cnVReko5?=
 =?utf-8?B?NWZyb25FK0c3UnFzdXpEcFM5bnNxYzRwWjRHMTgrMG93Q1RyK0RKc3poSDI2?=
 =?utf-8?B?WGJkWEFVeGdiUGRZeFhOanJFWFcvTnhqeW01dTFKRCsxVDB3aFAwOG9RQUYr?=
 =?utf-8?B?TEJHdnBKM2xyc3I1UVgxdzdTQ3NjWEIrRUdud2Mxd09tSytQOWJUWUVGZUdp?=
 =?utf-8?B?WHlRLzJvN1lObGxQRWk1dUdDSW16NFJOSS9jdVAwWGlrZHBTbG5HT1lBVXpV?=
 =?utf-8?B?WTQwTVBmcFd4cTVaVE9BWXprczRBMjQyMVZpV1dMOG92NzM0bnMxeXFPdmo3?=
 =?utf-8?B?Zmh0ejgrVHVVS3EvbEJnZDBzdE1vMkNEdkZFUzJUVldSUmlObnYxNFU2WG5x?=
 =?utf-8?B?eS9yZE1kV1lBbzlHQnd4QmlYV21OWU9NdlNDb3JBK1g3cVQ2TDlZRlRhSytr?=
 =?utf-8?B?RmxoSHowWjlRN0xaQ01XeHh6eTgvcUVSV05mOFFRbEdWR2Z6THdTcmR2SWpO?=
 =?utf-8?B?QnpZTTN6VDZaMGIvcVNpM1R6MWJ2TjNmYTdmc3lRalh1QXNMQXdrZGx4YnBv?=
 =?utf-8?B?NjFzV3FLSWRMN1lOQjB3VTNCVTA3c1kxWFo5V1dnR0VST3FUWS9RYlNCQmNr?=
 =?utf-8?B?M2JXaVFtb1JtU2hBTnNMaUtBYnVjTjFPR2l2Ni9IdVk2clVpUURtdVRTZzFL?=
 =?utf-8?B?dE1XOHNadnB2dGptKzgzUUl2R0ZjcTJ5QThhNzZ4Q1YvZWhNT0tJaHp6eTN6?=
 =?utf-8?B?QXdJbFpVb0J0SGlGNFJ3MXZDY0VkaS9DN1l0NFZvWGpSTXplVzB3N1lRNEJk?=
 =?utf-8?B?R2JWdFRTMWpaMURvdHlndFdQZWVSZlB4bUhDNVhKbDJtVXpWbmppMkhzcTRx?=
 =?utf-8?B?OUVBUXNwaWlPT2J5K2UycFFnKy84aDRQNktOUVhCVjR6cW9VZ3JlYnovOWEr?=
 =?utf-8?B?MEhPNzFuNXV5K3Uya2Q2VDVYZVR4NlBLVWlacVFmRjZJZjR0OVoyQUxEVHFt?=
 =?utf-8?B?UWk1S3ZBTXRNWi9pSVJ5d2hZc1I4VkZqWkFQTmhsWFVLZHRQdUtWRnNQQSti?=
 =?utf-8?B?TXo5MjBtQU02aFlKQllNSkRpRklLSGdqQ2lwY2w1bEM5TGJRWDdjNm4za2pR?=
 =?utf-8?Q?fCeBpeu5th0wqGSiyCyRdEiqaGJVG4xnYh4+cxJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35AC582785C4284B8CF72F11E3B3094B@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6111065-69c0-4fa3-f67e-08d94ff43317
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 05:14:09.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnGjpHYhT3GRxRW3pe9osDnPzUt7ev4jg87wQAkC5S14heZtNYTVSRY7lPf2pqsvcV9gYoyIdpEED+v+VqE58Hmn8LCs/u392YkvaIGNLwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2865
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlDQoNCk9uIDIwMjEvNy8yNCwgNDoxMyBBTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCg0KICAgID4gICBPbiBGcmksIEp1
bCAyMywgMjAyMSBhdCAwNDoyMzoyM0FNICswMDAwLCBCaWxseSBUc2FpIHdyb3RlOg0KICAgID4g
ICA+IE9uIDIwMjEvNy8yMywgMzoxNyBBTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCiAgICA+ICAgPiANCiAgICA+ICAgPiAgICAg
T24gV2VkLCBKdWwgMjEsIDIwMjEgYXQgMTA6NTI6MjFBTSArMDAwMCwgQmlsbHkgVHNhaSB3cm90
ZToNCiAgICA+ICAgPiAgICAgPj4gSGkgVXdlLA0KICAgID4gICA+ICAgICA+PiANCiAgICA+ICAg
PiAgICAgPj4gICAgIE9uIDIwMjEvNy8xNiwgNjoxMyBQTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCiAgICA+ICAgPiAgICAgPj4g
DQogICAgPiAgID4gICAgID4+ICAgICAgICAgT24gRnJpLCBKdWwgMTYsIDIwMjEgYXQgMDk6MjI6
MjJBTSArMDAwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+
PiBPbiAyMDIxLzcvMTYsIDM6MTAgUE0sICJVd2UgS2xlaW5lLUvDtm5pZyIgPHUua2xlaW5lLWtv
ZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQogICAgPiAgID4gICAgID4+ICAgICAgICAgPj4g
DQogICAgPiAgID4gICAgID4+ICAgICAgICAgPj4gICAgIE9uIEZyaSwgSnVsIDE2LCAyMDIxIGF0
IDAxOjQ4OjIwQU0gKzAwMDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPiAgID4gICAgID4+ICAg
ICAgICAgPj4gICAgID4+IE9uIDIwMjEvNy8xNSwgMTE6MDYgUE0sICJVd2UgS2xlaW5lLUvDtm5p
ZyIgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4+IHdyb3RlOg0KICAgID4gICA+ICAg
ICA+PiAgICAgICAgID4+ICAgICA+PiAgICAgPiBBbm90aGVyIGlzOiBUaGUgUFdNIGRvZXNuJ3Qg
c3VwcG9ydCBkdXR5X2N5Y2xlIDAsIG9uIHN1Y2ggYSByZXF1ZXN0IHRoZQ0KICAgID4gICA+ICAg
ICA+PiAgICAgICAgID4+ICAgICA+PiAgICAgPiBQV00gaXMgZGlzYWJsZWQgd2hpY2ggcmVzdWx0
cyBpbiBhIGNvbnN0YW50IGluYWN0aXZlIGxldmVsLg0KICAgID4gICA+ICAgICA+PiAgICAgICAg
ID4+ICAgICA+PiANCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiAgICAgPj4gICAgID4gKFRo
aXMgaXMgY29ycmVjdCwgaXMgaXQ/IE9yIGRvZXMgaXQgeWllbGQgYSBjb25zdGFudCAwIGxldmVs
PykNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiAgICAgPj4gDQogICAgPiAgID4gICAgID4+
ICAgICAgICAgPj4gICAgID4+IE91ciBwd20gY2FuIHN1cHBvcnQgZHV0eV9jeWNsZSAwIGJ5IHVu
c2V0IENMS19FTkFCTEUuDQogICAgPiAgID4gICAgID4+ICAgICAgICAgPj4gDQogICAgPiAgID4g
ICAgID4+ICAgICAgICAgPj4gICAgID4gVGhpcyBoYXMgYSBzbGlnaHRseSBkaWZmZXJlbnQgc2Vt
YW50aWMgdGhvdWdoLiBTb21lIGNvbnN1bWVyIG1pZ2h0DQogICAgPiAgID4gICAgID4+ICAgICAg
ICAgPj4gICAgID4gZXhwZWN0IHRoYXQgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZToNCiAgICA+ICAg
PiAgICAgPj4gICAgICAgICA+PiANCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiAgICAgPglw
d21fYXBwbHkobXlwd20sIHsgLnBlcmlvZCA9IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDEwMDAwLCAu
ZW5hYmxlZCA9IHRydWUgfSkNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiAgICAgPglwd21f
YXBwbHkobXlwd20sIHsgLnBlcmlvZCA9IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDAsIC5lbmFibGVk
ID0gdHJ1ZSB9KQ0KICAgID4gICA+ICAgICA+PiAgICAgICAgID4+ICAgICA+CXB3bV9hcHBseSht
eXB3bSwgeyAucGVyaW9kID0gMTAwMDAsIC5kdXR5X2N5Y2xlID0gMTAwMDAsIC5lbmFibGVkID0g
dHJ1ZSB9KQ0KICAgID4gICA+ICAgICA+PiAgICAgICAgID4+IA0KICAgID4gICA+ICAgICA+PiAg
ICAgICAgID4+ICAgICA+IHJlc3VsdHMgaW4gdGhlIG91dHB1dCBiZWluZyBsb3cgZm9yIGFuIGlu
dGVnZXIgbXVsdGlwbGUgb2YgMTAgwrVzLiBUaGlzDQogICAgPiAgID4gICAgID4+ICAgICAgICAg
Pj4gICAgID4gaXNuJ3QgZ2l2ZW4gd2l0aCBzZXR0aW5nIENMS19FTkFCTEUgdG8gemVybywgaXMg
aXQ/IChJIGRpZG4ndCByZWNoZWNrLA0KICAgID4gICA+ICAgICA+PiAgICAgICAgID4+ICAgICA+
IGlmIHRoZSBQV00gZG9lc24ndCBjb21wbGV0ZSBwZXJpb2RzIG9uIHJlY29uZmlndXJhdGlvbiB0
aGlzIGRvZXNuJ3QNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiAgICAgPiBtYXR0ZXIgbXVj
aCB0aG91Z2guKQ0KICAgID4gICA+ICAgICA+PiAgICAgICAgID4+IFRoYW5rcyBmb3IgdGhlIGV4
cGxhbmF0aW9uLg0KICAgID4gICA+ICAgICA+PiAgICAgICAgID4+IE91ciBoYXJkd2FyZSBhY3R1
YWxseSBjYW4gb25seSBzdXBwb3J0IGR1dHkgZnJvbSAxLzI1NiB0byAyNTYvMjU2Lg0KICAgID4g
ICA+ICAgICA+PiAgICAgICAgID4+IEZvciB0aGlzIHNpdHVhdGlvbiBJIGNhbiBkbyBwb3NzaWJs
ZSBzb2x1dGlvbjoNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+PiBXZSBjYW4gdGhvdWdoIGNo
YW5nZSBwb2xhcml0eSB0byBtZWV0IHRoaXMgcmVxdWlyZW1lbnQuIEludmVyc2UgdGhlIHBpbiBh
bmQgdXNlDQogICAgPiAgID4gICAgID4+ICAgICAgICAgPj4gZHV0eV9jeWNsZSAxMDAuIA0KICAg
ID4gICA+ICAgICA+PiAgICAgICAgID4+IEJ1dCBJIHRoaW5rIHRoaXMgaXMgbm90IGEgZ29vZCBz
b2x1dGlvbiBmb3IgdGhpcyBwcm9ibGVtIHJpZ2h0Pw0KICAgID4gICA+ICAgICA+PiANCiAgICA+
ICAgPiAgICAgPj4gICAgICAgICA+IElmIHRoaXMgZG9lc24ndCByZXN1bHQgaW4gbW9yZSBnbGl0
Y2hlcyB0aGF0IHdvdWxkIGJlIGZpbmUgZm9yIG1lLg0KICAgID4gICA+ICAgICA+PiAgICAgICAg
ID4gKEFzc3VtaW5nIGl0IGlzIGRvY3VtZW50ZWQgZ29vZCBlbm91Z2ggaW4gdGhlIGNvZGUgdG8g
YmUNCiAgICA+ICAgPiAgICAgPj4gICAgICAgICA+IHVuZGVyc3RhbmRhYmxlLikNCiAgICA+ICAg
PiAgICAgPj4gDQogICAgPiAgID4gICAgID4+ICAgICA+IFRoZSBwb2xhcml0eSBvZiBvdXIgcHdt
IGNvbnRyb2xsZXIgd2lsbCBhZmZlY3QgdGhlIGR1dHkgY3ljbGUgcmFuZ2U6DQogICAgPiAgID4g
ICAgID4+ICAgICA+IFBXTV9QT0xBUklUWV9JTlZFUlNFRCA6IFN1cHBvcnQgZHV0eV9jeWNsZSBm
cm9tIDAlIHRvIDk5JQ0KICAgID4gICA+ICAgICA+PiAgICAgPiBQV01fUE9MQVJJVFlfTk9STUFM
OiBTdXBwb3J0IGR1dHlfY3ljbGUgZnJvbSAxJSB0byAxMDAlDQogICAgPiAgID4gICAgID4+ICAg
ICA+IER5bmFtaWMgY2hhbmdlIHBvbGFyaXR5IHdpbGwgcmVzdWx0IGluIG1vcmUgZ2xpdGNoZXMu
IFRodXMsIHRoaXMgd2lsbCBiZWNvbWUNCiAgICA+ICAgPiAgICAgPj4gICAgID4gYSB0cmFkZS1v
ZmYgYmV0d2VlbiAxMDAlIGFuZCAwJSBkdXR5X2N5Y2xlIHN1cHBvcnQgZm9yIHVzZXIgdG8gdXNl
IG91ciBwd20gZGV2aWNlLg0KICAgID4gICA+ICAgICA+PiAgICAgPiBJIHdpbGwgZG9jdW1lbnQg
aXQgYW5kIHNlbmQgbmV4dCBwYXRjaC4NCiAgICA+ICAgPiAgICAgPj4gDQogICAgPiAgID4gICAg
ID4+IEZvciBoYW5kbGluZyB0aGUgc2l0dWF0aW9uIHRoYXQgdGhlIHVzZXIgd2FudCB0byBzZXQg
dGhlIGR1dHkgY3ljbGUgdG8gMCUsIHRoZSBkcml2ZXIgY2FuOg0KICAgID4gICA+ICAgICA+PiAx
LiBKdXN0IHJldHVybiB0aGUgZXJyb3IuDQogICAgPiAgID4gICAgID4+IDIuIFVzZSB0aGUgbWlu
aW11bSBkdXR5IGN5Y2xlIHZhbHVlLg0KICAgID4gICA+ICAgICA+PiBJIGRvbid0IGtub3cgd2hp
Y2ggc29sdXRpb24gd2lsbCBiZSB0aGUgYmV0dGVyIHdheSBvciBvdGhlcnMuDQogICAgPiAgID4g
ICAgID4+IEkgd291bGQgYmUgZ3JhdGVmdWwgaWYgeW91IGNhbiBnaXZlIG1lIHNvbWUgc3VnZ2Vz
dGlvbiBhYm91dCB0aGlzIHByb2JsZW0uDQogICAgPiAgID4gDQogICAgPiAgID4gICAgID4gSSB0
aG91Z2h0IGlmIHlvdSBkaXNhYmxlIHRoZSBQV00gaXQgZW1pdHMgdGhlIGluYWN0aXZlIGxldmVs
PyBUaGVuIHRoaXMNCiAgICA+ICAgPiAgICAgPiBpcyB0aGUgYmVzdCB5b3UgY2FuIGRvIGlmIGR1
dHlfY3ljbGUgPSAwIGlzIHJlcXVlc3RlZC4NCiAgICA+ICAgPiANCiAgICA+ICAgPiBUaGFua3Mg
Zm9yIHlvdXIgcXVpY2sgcmVwbHkuDQogICAgPiAgID4gV2hlbiBkdXR5X2N5Y2xlID0gMCBpcyBy
ZXF1ZXN0ZWQgbXkgZHJpdmVyIGN1cnJlbnRseSB3aWxsIGVtaXQgdGhlIGluYWN0aXZlIGxldmVs
Lg0KICAgID4gICA+IFNvLCB0aGUgbmV4dCBwYXRjaCBJIG5lZWQgdG8gZG8gaXMgdG8gYWRkIHRo
ZSBjb21tZW50IGFib3V0IHRoaXM/DQoNCiAgICA+ICAgTm90IHN1cmUgSSBnb3QgdGhlIGNvbXBs
ZXRlIHBpY3R1cmUgbm93LiBUaGUgdGhpbmdzIEkgY29uc2lkZXIgaW1wb3J0YW50DQogICAgPiAg
IGFyZToNCg0KICAgID4gICAgLSBJZiB5b3VyIGhhcmR3YXJlIGNhbm5vdCBlbWl0IGEgMTAwJSBv
ciAwJSByZWxhdGl2ZSBkdXR5IGN5Y2xlLCBub3RlDQogICAgPiAgICAgIHRoaXMgaW4gdGhlIExp
bWl0YXRpb25zIHNlY3Rpb24NCg0KICAgID4gICAgLSBBc3N1bWluZyB5b3VyIFBXTSBlbWl0cyB0
aGUgaW5hY3RpdmUgbGV2ZWwgd2hlbiBkaXNhYmxlZCAodGhhdCBpcyAwDQogICAgPiAgICAgIGZv
ciBQV01fUE9MQVJJVFlfTk9STUFMIGFuZCAxIGZvciBQV01fUE9MQVJJVFlfSU5WRVJTRUQpIHRo
aXMgaXMgdGhlDQogICAgPiAgICAgIGJlc3QgdGhhdCBjYW4gYmUgZG9uZSB3aGVuIGEgMCUgcmVs
YXRpdmUgZHV0eSBjeWNsZSBpcyByZXF1ZXN0ZWQNCiAgICA+ICAgICAgKGFzc3VtaW5nIHRoZSBo
YXJkd2FyZSBjYW5ub3QgaW1wbGVtZW50IHRoYXQgaW4gYSBub3JtYWwgd2F5KS4NCg0KT3VyIGhh
cmR3YXJlIGlzIHRoZSBzYW1lIGFzIHRoaXMgZGVzY3JpcHRpb24uIA0KU28gSSBkaWRuJ3QgbmVl
ZCB0byBhZGQgdGhlIGxpbWl0YXRpb25zIGFib3V0IHRoZSBkdXR5IGN5Y2xlLCByaWdodD8NCk9y
IEkgbmVlZCB0byBub3RlIHRoYXQgdGhlIGR1dHkgY3ljbGUgMCUgaXMganVzdCB0aGUgaW5hY3Rp
dmUgb3V0cHV0IHRoYXQgZG9lc24ndCBoYXZlIHRoZSBwZXJpb2QgY29uY2VwdC4NCg0KICAgID4g
ICBJIGhvcGUgdGhpcyBhbnN3ZXJlZCB5b3VyIHJlbWFpbmluZyBxdWVzdGlvbnMuDQoNClRoYW5r
cy4NCg0K
