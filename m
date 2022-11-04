Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B6619BAD
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiKDPch (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKDPcf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 11:32:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F62D771;
        Fri,  4 Nov 2022 08:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkL+wR3NXnyIaipF7yfzr3ec+/60I5psVMIsmMC20yit8UnLOT+8OfgBUXVaf6jcENJxCmXglMQT+oaHArKtZhiG2ulqZU+wYPVYlKDnCI0maG8yaMoGg6E08Ej1mzmcmKwHuKYeZjFoJiRZXZ0ovsbxnfiNcYdVcMmOwUjpSCwETEovR1OxagqpYYhjOpP372iBlKyVJhL2nE5U02O3G/7xqrCVDsTx6VMP6EsE/U1vN0PLmCsRF+8FuUvE7ptO2QpusnkEhg7auNkiyulH6w8co78nPM1PjJHe16r15SibTOhPgrgVKyzv7e24ycz2nFoNEI98+9ajFhyRYhbVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3blPguoRP9ddxbFSGSxpdkRCckDcLbrV67OE7LtaZk=;
 b=ZXVrf7rL5PX7MwbQmYXbmMjgL3I+Z26CrJPJtj6hwKEx9gU8nb97ExB4gEgquRyEbTdN1xVcaRlr9tIXW4HZe2O+ItvWAFdHQOfOEsIuA/tEGxb1zq/aEskmyMi9tSJ7AimFa17ELKXghrUhDv7gq0XrhCTleoUxTLt5Xk2XqnjqfESv2UdNGakh0G1pYeB7yUAE1sLO65HPFfjB9KOM8wn8qjwR8ejoM3nJam5+e3lriQYEseMwM7m8tjTmU3c5g8QGQZU9RNthpdNO6TdlQ1nkDlVZTQxhwHxHIZLsgHDjbZLg8gPABEU6PnvJyR4BaRCcfmKBOKPR+bAjRbH1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3blPguoRP9ddxbFSGSxpdkRCckDcLbrV67OE7LtaZk=;
 b=tnCF/G/UZqzZzG/2/IQoXzs6elfYmaoWsbcgU/OjW+NOCUyDqyUusGdx26XhiC+U4zmAYpKlQy5+tIWMnBRBeD1vR5mZ5d1iAC82chlayWky4ixoTVuFOyfHcvgKkGM5sGVZt8RCW4MJpc/fiDKm6b6abcmmFf5ZdCJNt1WtrEQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5640.jpnprd01.prod.outlook.com (2603:1096:604:c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 15:32:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.023; Fri, 4 Nov 2022
 15:32:31 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs
 property
Thread-Topic: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs
 property
Thread-Index: AQHY8F4Z0M4T+LP7zUaTYMhsdADakq4u3OCAgAAFgKA=
Date:   Fri, 4 Nov 2022 15:32:31 +0000
Message-ID: <OS0PR01MB592205ACB2F877F798437837863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-3-biju.das.jz@bp.renesas.com>
 <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
In-Reply-To: <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5640:EE_
x-ms-office365-filtering-correlation-id: b220f20c-bef1-4eb2-f18a-08dabe79c9e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9v4rd2KXZWL6cICTm8mj8njumdfnjbZIrL4DemyJR1LH5d9R8w038X9Qkq9jVLYRS4wPe3QnM3Oft3Cf+mM/4Vk8RN2ZrLPnNX8yvBDt4tG3WLeJ4ix3aOiJRt7BohB5CU6hbq6/awpPdNxzHB/H9NZHLWzpfoxpT4/JoSINnLYcsTIbWgcl0OwCjM4p0GcE0Ps6ythl0J/OszcY1EjIVyg6i/OzoufiMGh5QsIuT30h1uClPS/R+ERCvLI0X0jGuVnsjalMRVbVW1WcvlZ8K5qOWgB7b2h/jQXcY3sOwxoEhZ963FS8wuboEnBhSSVnxae0wW1xigGk6Yte2ImUwbCLK83i6pmfINb5roS5TTmykavSYXB5v3ixAt/esFMyUz05wjbQBRJdsBsXDFNvN/Q8LbMnhTcMm5GbFth9a4jVZVjeWsrM7lkUwKpWl4GdzC6jKOooYNRiYv9U9U9pbF+fYAV6PTSIpHwBYqun/KHPyt0CzzM1vSrvAtlaRgbVtCdpQr+mOmDbY3QScm6T+5MmAoIYlbYHpM9PUKAN3VHRXRdDIXlhuU88Gxk/e3Kl7wPrNkK9kx1aWLV93NoM6K+p2Sdb7bo72WA2/Ry72TgkpAJc3ycUu9nWjSp+joO/PgEs1efi3hIWS5PKACzy7gGITtXX2dd//2p69dAzXHU4nLiYISDOE3oglh7LrxcUuN9TxZV6iwzCdCsfJ+6oWtCfJ9WhVn7R4m4Fl6O4haCIU7P94QmniglWE1gtHbYUvHlIbCQ25GVllwLGQGxAg6sjC4hpH62koMH5wLrEtCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(9686003)(26005)(83380400001)(186003)(38100700002)(38070700005)(122000001)(2906002)(5660300002)(8936002)(55016003)(966005)(478600001)(71200400001)(7696005)(6506007)(53546011)(8676002)(4326008)(66556008)(66476007)(66946007)(66446008)(64756008)(76116006)(52536014)(41300700001)(316002)(110136005)(54906003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXhnV3RzSCtVUGxFSW56K2p4R0hWUnd3Qzd0L1dGbGREUXpiNlI5ZDVsSHp6?=
 =?utf-8?B?MTRnQVovc0hwYyt1OW94ZERpcUJmMlphd0VEMG52aVFubUttSDgzd1R0TWhE?=
 =?utf-8?B?Z0ZRYjlRR29KSkVhUmIvY1YyRXZiY3ltTTVMMnBvS1RIWlhLYjMyVVZVQVNY?=
 =?utf-8?B?ODVwSDY4US82WW83WHRBYlpVeC9Ta2RRVElPZC9uVUJ3N1JGT2NudUpUUUpL?=
 =?utf-8?B?amdReXRGQ09GclBwdU5wZ3h3Wnk4bXFMNEplZEd0ZnprZGNPclF1b1MwK2RE?=
 =?utf-8?B?NTd4VnNwN3gzVm5FenlvNGV1RlZ4OGpQMVNHZHUyMENvUDBTL1FxZktCcVFt?=
 =?utf-8?B?TXFJZ2NHU2ZzZTZRdXVpUkUvREczdjg4SUgyWktYNWF0VGdLZE9uRHllelFN?=
 =?utf-8?B?VFVMUk1NZ1Z0d2tlTXAvdmxoaklubzlOaytyOU9hQ3kyNGNjM1lLQXFjTWpl?=
 =?utf-8?B?WjVybnBITk42WWpqL204YUorVHdSRUFXalFGWTFTdFdjdGxpSDFEb1lCYjBE?=
 =?utf-8?B?K2kxa1BvV051ZUNZV3l6ajRBMUhFZm9oTXY0SlVxR2hOaFBOTkJCNXF3c0pV?=
 =?utf-8?B?NisyQ3ltZW0wc1ZsejN0S2RHV3kweW1GNW45ZGUrTktTUDFSekc1NUlobWVQ?=
 =?utf-8?B?ZXpzRWFQa0Y2TDk2eElHTWJ5VXBZRm1BTDJxaVBUYW40NVdqMHE2VUltUmVk?=
 =?utf-8?B?OGpLQlRyQTJZVmxrQnR5VlJmYzd4NzV3ZmJsTnBSdEFSanlSQkhHditoRko5?=
 =?utf-8?B?V3RqbU1RRHN0dEMzTHRGdUs4SmxRdDRkd0tWODJqaG1ISmRyVms3OHJhb2Na?=
 =?utf-8?B?ZEFYODdSc2hzbXYzU0I2anBGTDJlMEJvVy83THY2bUZCNlp0UkpvVTNCcXUz?=
 =?utf-8?B?WTN4V2NGaTVFemRESDNsUHpOdjFOQ1lqRUp2MlZ4VlFqbmVnUHhWUnlFSnJ1?=
 =?utf-8?B?bEpjOGlINzRnWjI3NjZmTGhLZjVva3NsOWRqcUpBbE5jaVlUb0luNXZ1SzVJ?=
 =?utf-8?B?b2o3UEE1Z20vdWE5MUVGbWFyVlQ2TDdtUGgybXpIMVczVGhuWGd5TStJVE4v?=
 =?utf-8?B?VXBLdkdKVG91bmJ3SlBEY1JFUmh3MUxpakJmV2ZrSUMzVzZsN21YNWw0ZkhN?=
 =?utf-8?B?NGhLRTNRQitnaFhFN2NLU0Y2UVJYZUo1MktUUllBZTBGVlNuL3k1MXhvdi9o?=
 =?utf-8?B?MFJwdy9RNmlyZWVQM1ZMZzdPdGpMVFVMLzBXQWs2cm5PMjQyaEwxdFY0L1VJ?=
 =?utf-8?B?NGE2d0RvZ0IvWTVhMkRobnBRTnNYS29XZ1NvWm8xdUZMRitad2xPMUVoTmZk?=
 =?utf-8?B?V0V0UWZNZE1PL0t0cUJnQ1cxQzljT3VJN3BQRDIvaHZyNStyYm9lWmlicy9R?=
 =?utf-8?B?aWVTaUVtVlhZOER1NVlRY2RWRXhVOEM0cE05YjRrVDJvUTEvTXFrRXlzaGd5?=
 =?utf-8?B?Qzk2eThVOXZMZ2JZUU9xYms4YUs2cjNDMU1BUDR5R25hQjlzemR2WURHZmx4?=
 =?utf-8?B?Ni9LMDVnTWhkaHVKTDV2M2RIbmJ0N2d1U0U0dHFvMHRhNlZqdEIzQVdHOGxT?=
 =?utf-8?B?ekZsWUZMdG0vaGVacTk0b0VOTU1hNGVTSFI4dHJpZ0xUbDdEVi83djBLaDZQ?=
 =?utf-8?B?UWc1cnVFbFEzZUc2ZzdEZFpnWmx5OUtxbGwrYXNQcjNLbWdwWWNWc2Z5N0lC?=
 =?utf-8?B?NFF1L2o5UUxqTXRyWEJGUFJ3NE5taDBQOGduTzh6MlZvcVVVZlJMSUp2d2VY?=
 =?utf-8?B?MWlNb1p3RG5BRmdhOS9zV0RLTlNPZ25vcTlEenNpVlRkS0V0Y1MwMmg4SVhF?=
 =?utf-8?B?YWJvRzZndDFJK0pycGFxY0FocWgrcWl2NElqUU1WYXl5Um5qRWp0a3pMUlNk?=
 =?utf-8?B?U2VVVjBldS9ndXVDZEJhRU91UjMxRFNuVDMyNXA5UUR3Z1lVcjUrSmxpZmRh?=
 =?utf-8?B?TC9QdlZLbnl0VGpMMnd2WVZYWGZ2eEduc2FRa3dXRXZqOTZlY2xHbFBMb1dH?=
 =?utf-8?B?TXAvUC9MZFRVSmtrSWs5Zy91ZUF1MFI4VXJ3QS9aTmZrOG4vN2hONEt2VUhZ?=
 =?utf-8?B?ZUkybnRXQWQxWEtVUnluSnJZQWRDVWpxQjkzcy9ZYmN4QWNleDNCS3pGN2VR?=
 =?utf-8?B?QzZqVFROVDJsVEdLRGRBWnZiMXRmMGZGaW5oZFllZm5mN3NJWUFZcmFydU9a?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b220f20c-bef1-4eb2-f18a-08dabe79c9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 15:32:31.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvfBhaGTR/7soM0U2DqGKydUoTdlKnCSC3nJTwJs5If9921QP2FBAL+xB7H1d21P7cCWhHsvMdm9FZ8uo3xrCBtaAT+sJ54iclhqnoqF0AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5640
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGR0LWJpbmRpbmdzOiBwd206IHJ6ZzJsLWdwdDogRG9j
dW1lbnQNCj4gcmVuZXNhcyxwb2VncyBwcm9wZXJ0eQ0KPiANCj4gT24gMDQvMTEvMjAyMiAxMDo1
OSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gUlovRzJMIEdQVCBJUCBzdXBwb3J0cyBvdXRwdXQgcGlu
IGRpc2FibGUgZnVuY3Rpb24gYnkgZGVhZCB0aW1lDQo+IGVycm9yDQo+ID4gYW5kIGRldGVjdGlu
ZyBzaG9ydC1jaXJjdWl0cyBiZXR3ZWVuIG91dHB1dCBwaW5zLg0KPiA+DQo+ID4gQWRkIGRvY3Vt
ZW50YXRpb24gZm9yIHRoZSBvcHRpb25hbCBwcm9wZXJ0eSByZW5lc2FzLHBvZWdzIHRvIGxpbmsg
YQ0KPiA+IHBhaXIgb2YgR1BUIElPcyB3aXRoIFBPRUcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1ncHQueWFtbCAgICAgICB8IDE5DQo+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wd20vcmVuZXNhcyxyemcybC1ncHQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzJsLWdwdC55YW1sDQo+ID4gaW5kZXggNjIwZDVh
ZTRhZTMwLi4zMmY5ZGVhZTg5ZTUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzJsLWdwdC55YW1sDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9yZW5lc2FzLHJ6ZzJsLWdwdC55YW1s
DQo+ID4gQEAgLTI0NSw2ICsyNDUsMjQgQEAgcHJvcGVydGllczoNCj4gPiAgICByZXNldHM6DQo+
ID4gICAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4gKyAgcmVuZXNhcyxwb2VnczoNCj4gPiArICAg
ICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Ig0K
PiANCj4gTm8gbmVlZCBmb3IgcXVvdGVzLg0KDQpPSywgSSBqdXN0IHJlZmVycmVkIHJlbmVzYXMs
dnNwcyBpbiBbMV0gYXMgZXhhbXBsZQ0KDQpbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcmVuZXNhcyxkdS55YW1sP2g9djYuMS1yYzMj
bjg1DQoNCj4gDQo+ID4gKyAgICBpdGVtczoNCj4gDQo+IFlvdSBtaXNzIGhlcmUgbWF4SXRlbXMu
Li4gYnV0IGlmIHlvdSBoYXZlIGp1c3Qgb25lIGl0ZW0sIHRoZW4gYmVsb3cNCj4gIml0ZW1zIiBz
aG91bGQgYmUgIiAtIGl0ZW1zIg0KDQpNYXggSXRlbXMgaXMgOCwgYXMgd2UgaGF2ZSA4IEdQVCBo
dyBjaGFubmVscy4NCg0KQmFzZWQgb24gSFcgYm9hcmQgZGVzaWduLCB3ZSBzaG91bGQgaGF2ZSBm
bGV4aWJpbGl0eSB0byBkZWZpbmUgc29tZXRoaW5nIGxpa2UgYmVsb3csDQoNCnJlbmVzYXMscG9l
Z3MgPSA8JnBvZWdnYSAwPiwgPCZwb2VnZ2IgMT4gPCZwb2VnZ2EgMj4gPCZwb2VnZ2QgND47DQoN
Cg0KPiANCj4gPiArICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhh
bmRsZSB0byBQT0VHIGluc3RhbmNlIHRoYXQgc2VydmVzIHRoZQ0KPiBvdXRwdXQgZGlzYWJsZQ0K
PiA+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IEFuIGluZGV4IGlkZW50aWZ5aW5nIHBhaXIgb2Yg
R1BUIGNoYW5uZWxzLg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDwwPiAtIEdQVCBjaGFu
bmVscyAwIGFuZCAxDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDE+IC0gR1BUIGNoYW5u
ZWxzIDIgYW5kIDMNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICA8Mj4gLSBHUFQgY2hhbm5l
bHMgNCBhbmQgNQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDwzPiAtIEdQVCBjaGFubmVs
cyA2IGFuZCA3DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDQ+IC0gR1BUIGNoYW5uZWxz
IDggYW5kIDkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICA8NT4gLSBHUFQgY2hhbm5lbHMg
MTAgYW5kIDExDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDY+IC0gR1BUIGNoYW5uZWxz
IDEyIGFuZCAxMw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDw3PiAtIEdQVCBjaGFubmVs
cyAxNCBhbmQgMTUNCj4gDQo+IHRoZW4gdGhpcyBjb3VsZCBiYXZlIGVudW0gb3IgbWluaW11bS9t
YXhpbXVtLiBDYW4geW91IHRyeSBpZiB0aGVzZQ0KPiB3b3JrPw0KDQpPSywgSSB3aWxsIHRyeSBz
ZWNvbmQgaXRlbXMgYXMgZW51bSBhcyBpdCBpcyBwcmVkZWZpbmVkIHZhbHVlcyBhbmQNCldpbGwg
bGV0IHlvdSBrbm93IHRoZSByZXN1bHRzLg0KDQpDaGVlcnMsDQpCaWp1DQo=
