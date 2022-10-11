Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A25FBB32
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJKTNu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKTNt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 15:13:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA346D9A;
        Tue, 11 Oct 2022 12:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4c9mxKa9uzRkr0UqoRDmV0WvH0A+C5qPts2heUupY/2Cftdt4hETUBN7T1BgZhC3v600hgjutTCxNRryUx2fxf1iUefE/yyg3JKCsQwSLtURkEknADPjdfko9C1R9Nh4Z53yiQu6dBes5/j8vHb+nmEfwRMJsJLj5FNhXqQZhAxTAu6xtjyEcUi9s7cwXtira0T3t0kuY+Vqfty2MjwafvLG5sceJCPJofw7x/ge1WJ0/i5IHT6iIRsILQLGUZRNfGmtyUHRwPqBGsZBcXZDlZb3NsfnzAUEjpGeSAhuymxVpSKwqoldSkWwucrJSVUPMRa4dCykpJ9kz5X5VmAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8d7DHXWbzWIfcFIqZAehIjLtW4JuIOc0j3w+HaB+Vc=;
 b=MSjCMPTex62MpCovOWPgElgLay7CmcqcvzByZ3oWSsZV2m7gug0ClHKtaxhZyfqxIEL2Si6b3tOapCWNaJ764+XqDoav1TuYDHNinDN0c67uuwUn7iXjDzfScqcpGtdosmoZr01glXsr61iTJudQdpMrNsem/B/T4VwwPNQdMgpobnGBnIbnb0Oink91eAXcKvAE32DAy23AlILSTpxnBCkAhYgJKb6pXVg4W/nR11z2r8cLW/lyKPf4RXa8edMpeuSKww0bKeVzHFb3YRq3pkrCSkgw4lA9xLw9PE7N10vf47PgEWb2nMof/Y+io2BNIQLQBgefMZcyG0sYaR1gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8d7DHXWbzWIfcFIqZAehIjLtW4JuIOc0j3w+HaB+Vc=;
 b=Y2dEqFqtfh7FA/s2NY9itAvyuWXHrrpSF+3Kn7X1SnvYRgvvV/BIXcgbBPipuNO+rVyRH0swdM3iyQoS1aYq5vaxvBMgg1aICFow4d/RN2hJJf9PHELZ4o9MLcN9aELYyU1aLHnDrSLYo2ppLgAURebkm426jrUVOYCJWORUKNE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9422.jpnprd01.prod.outlook.com (2603:1096:400:1a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 19:13:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 19:13:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Lee Jones <lee@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Topic: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64JjDKAgAACnKA=
Date:   Tue, 11 Oct 2022 19:13:44 +0000
Message-ID: <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
In-Reply-To: <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9422:EE_
x-ms-office365-filtering-correlation-id: 66187783-e737-4610-ab32-08daabbcb7ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TLED1Lx+FJG306kP7mIfrA6YPwPe2ugDO5tWLITlVplPLmL3ReELgBoJCDwy+ac2KcFUBI9cm5DqLcMXi+PUqHpC+KY4WPakpH2A1tyOzCS9rkQ2RhaadPiGDCy/pnVAnFo7cg56LvwvszR9bE9WFilzeotZZSd1NjF1Slh/l90rQquKk5v/ERWFC8azM1P7lxA7UmAMwYX1ksYZaCdD4daAZl01EELQZpOfCUj+jEqQyS28kij0QsMnHwtSVj4wsvDMVUZIdVm78ihMP/h3fFxqWBopfcNSuwqW3fvWAQg5fU5m1xPCpEqHErZYEuJDyAOp7RCtcGKuIHWnDbzB3WXWe51LYDv1iXhnkEwja9zYVm5HBAMcXUKq7NJU580NZZx4D2FfhbgYa3cNwWg28XLBh5g9gQBkkrkIAcPG5qRdmr+8pGAN9uJnAJX5YeOrAC3FoGzZJpRb/I2LzXtcweCQGXxbbMY33eC6Uv61tpRtbLGZHsAVJeJFJbOZnqAemqCBYvtFiGUGjUSLbVjKGIMPKZMmNf8lqJuAdHE4ScPckEqkiNnwX2giFk2ChBLdr5VgualmgOrRkIQRPoXB7cH8NVyhKbkf79jVoh1+/ZHkubpunKW4qgvH3iN+R0u0j1y3nGUjIKR8701o2fuIaoI4cTsaXz/Rx0sZ6SNSKk6N3lMLnmZ8Z0BdZ8uv5fGDOyYUzAEj91ARUQ7omd2r2MDUMjpsZOv0o31U7GrRUryMSi4Fdm/GovUt1g6+sSHDTTzgx7gNeoNo5UfPGdOKsyCKx/bDLobPpGXSlUknqMs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(5660300002)(52536014)(8936002)(38100700002)(2906002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(41300700001)(86362001)(33656002)(38070700005)(316002)(478600001)(186003)(966005)(6506007)(7696005)(53546011)(26005)(9686003)(110136005)(54906003)(122000001)(55016003)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZldlTU1kbFR6T2FNMk51cHVqWVNNRUdUUi9IQW9FVDhscC9lc3pxSURndU1P?=
 =?utf-8?B?NFYyNTBxcUd4USt6MjlkclhCWVBDMStvWFp6Rk0xRC9DaFAvQkhMWmM0dVlr?=
 =?utf-8?B?YkowOFg3TFN6RlJlaXRuT0RmT29qTWhFREE1b1o4dTdPbEIycEJ3Zmo1eWxi?=
 =?utf-8?B?TUhqYVIxenBGenFuKzhXRGpqU1BFcjRiZ1FqQ0ZSMGp5RTBjU25LVWVhTkVv?=
 =?utf-8?B?NnVoaGdFWC9lSkY3YTVpUUFER29Fb25weTAwYkFneGdKWEFsM1NaQzM2K1g2?=
 =?utf-8?B?dk8wTytaaU5JUDg5N1BIczdYT0xBdlM1NG13TExWeDV0enZCVTYzeklkMVZ4?=
 =?utf-8?B?dE0rT3MzbHBReVd0S2czU0VweFNoS2lKMzlBcFlPR1pJaVJhZGMxWmh0enJ0?=
 =?utf-8?B?dWQ4Z3FCdmNQOGNpQ2FEOHViQVZIaCs2ZTNhdCs3dUsyc3FNSlo0NGRiM0Fv?=
 =?utf-8?B?N1ZRRDc0Z1M2a2JVZFpzaWt4OThhci94MjVmOVE2UnpxRk9MNW16MDUrSkpz?=
 =?utf-8?B?NU9uSFMrUWN5OUphbldhSzhRaklQUVFmYXU1MHRoNEM1cVJncXUrQWcyR2RF?=
 =?utf-8?B?Tkc2VzdSZlZRa3hIRWJzdG54WmxLOFNkUW9hdG5PQzBoK1QySnN1dXVxZHVC?=
 =?utf-8?B?R0tyYlZRTHhucjZJeWFwMmpIMW9NSi83Sm5KYUc1VnoxcXk5MCs0UHNmNkxm?=
 =?utf-8?B?N1ZOdDZkbjB3MHVFR1Z4SnpRem4vWTk5UFR0dFFrWDVselp5M0Nwd0hjMWZG?=
 =?utf-8?B?VXJXZE14QlVqNEtyTndWd1B4bDFCVFNtcEFlOS9BazZ3VUlnNkZsSkltVHY2?=
 =?utf-8?B?YUt6YjE3ZnQ4TnM5SG5NTmZIb2toYmpHQW9wYzM3d0ZRanhzd0ZXd0pLay9Q?=
 =?utf-8?B?U3FWUy9mNmVSTXQxdUhBU2xWend6Nms1MFRpd1U0akRWYXh5ZlVJdUhwS2pI?=
 =?utf-8?B?T1pPS2t6ZWVaUXBONjVldGE1N3pvQ3U2QmIrSXFrRnBTdlZSd3IydWM5b21R?=
 =?utf-8?B?YjZOU1NVZnluTCtEbGg0M3hvOFZsZHgzbENiLytLbEhja2V3djMwaTVVTXBT?=
 =?utf-8?B?aXAvMU8zRGcvNk9oMWlKRTBMbkQ5Mldva050L010VllEcnlDYXpubit0NmFH?=
 =?utf-8?B?bHVLUGdzV09UOGExYytXQm1jRTVwU21NMmlUcUZjM1ovZWMwK0hlUUtLYkFm?=
 =?utf-8?B?VmVKRWV0dTJVVzRYQy81djZ6VUswL1Ftbk1OUG0wNjNTTkloZ2dLMEVaVWRr?=
 =?utf-8?B?WDAzajRLZHUvQVNzTUNadmtydURSOU9PVEZIb3BiNDZkazMzdHgwcGFQMVNh?=
 =?utf-8?B?bEo5dTA2d2pZNWhESkpoMXc0R1h6d0V2MEJZdjZEdHNXYU5KcUhwOGh4dDJK?=
 =?utf-8?B?OWEzdmRyTkNlR0RCWURBemwzbWY5cUZ4TXkwUHNIam5lVG1GYitPYUYvRXRi?=
 =?utf-8?B?Ym1CeG84UFMrZ3BGQ0JheGdRWUVPYjNBZ0YyWlJOY2p6eHNxWmlmTC9UNW1K?=
 =?utf-8?B?eXBWa2duRkp0UVJ2Ymt5NjhZSytKVWh2dnNjVFhhbzlnTzdYTFBoRTRyMFhW?=
 =?utf-8?B?V2QwVG1vb0FmMHYwT3J1aHdHb3FoaXUybUJnZmUvam43OHpSdTJRQ1B3dTcv?=
 =?utf-8?B?b25UdDhsbzF4cUJOaERTUlBKWTRKVHN5blNyUFI5QTk3dWR0NENFNlBnRnZR?=
 =?utf-8?B?dVE4NXhYbFUzMnRWZkF3aTh6UldZdThLa0poS2prdkhHazVjbHV0UDc3Y0Zt?=
 =?utf-8?B?UDBZWVFtemZHNzl3MStJdnBMQmRzeUNDVlBBWFZGY3BzOFY1VjVlOVo0b2d4?=
 =?utf-8?B?UmVmamNpM2ZmUW9QKytrZ1dUTkVOOE9aR096aGlHWEJXazc5cG5CUXcrcXdo?=
 =?utf-8?B?Ynk5L2cwTEYwanZXNk5TWlZCRUt4RWI1bU9qNFFTL2FmaHIxMXNHN2Y2c3Nj?=
 =?utf-8?B?M0dmQW90QS9vbHNEbS83dy9tT1k3TkVJbUNpWXQ3aDVzaWlOeGN6c29SN3Zk?=
 =?utf-8?B?U0VyVFU2eDJmK0RQQ2hmdC84L2dxVVhPUTFmTWFJaUtPdTRiOWlkZHZNTGdD?=
 =?utf-8?B?ZG9aclhEN3AwWlNMdmtQeVpuVVR5aGVNWVNnKzZua1N6Vjdzdjh3ZjBTaXhT?=
 =?utf-8?B?UUlGcVEyaDdBem10OGsvRnVaUllQa2hVUnVyWmVreWR6ek5QVDl4MkxtcHha?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66187783-e737-4610-ab32-08daabbcb7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:13:44.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG3Q401Vja9j7be1q0LpnUIGRdcyykru5VjmJC7VWvXjv8Mk+ymu9B7cy+2LQwh+TNMRDwm+euubNYtMWp/7G3zNyri/iK1Kcxe4WgY1yU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9422
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0gbWZkOiBBZGQgUlovRzJMIE1UVTMgUFdNIGRy
aXZlcg0KPiANCj4gT24gMTAvMTAvMjAyMiAxMDo1MiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gQWRk
IHN1cHBvcnQgZm9yIFJaL0cyTCBNVFUzIFBXTSBkcml2ZXIuIFRoZSBJUCBzdXBwb3J0cyBmb2xs
b3dpbmcNCj4gUFdNDQo+ID4gbW9kZXMNCj4gPg0KPiA+IDEpIFBXTSBtb2RlezEsMn0NCj4gPiAy
KSBSZXNldC1zeW5jaHJvbml6ZWQgUFdNIG1vZGUNCj4gPiAzKSBDb21wbGVtZW50YXJ5IFBXTSBt
b2RlezEsMiwzfQ0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGJhc2ljIHB3bSBtb2RlIDEgc3Vw
cG9ydCBmb3IgUlovRzJMIE1UVTMgZHJpdmVyIGJ5DQo+ID4gY3JlYXRpbmcgc2VwYXJhdGUgbG9n
aWNhbCBjaGFubmVscyBmb3IgZWFjaCBJT3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjMtPnY0Og0K
PiA+ICAqIFRoZXJlIGlzIG5vIHJlc291cmNlIGFzc29jaWF0ZWQgd2l0aCAicnotbXR1My1wd20i
IGNvbXBhdGlibGUNCj4gPiAgICBhbmQgbW92ZWQgdGhlIGNvZGUgdG8gbWZkIHN1YnN5c3RlbSBh
cyBpdCBiaW5kcyBhZ2FpbnN0ICJyei1tdHUiLg0KPiA+ICAqIFJlbW92ZWQgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciByel9tdHUzX3B3bV9kcml2ZXIuDQo+ID4gdjItPnYzOg0KPiA+ICAqIE5vIGNo
YW5nZS4NCj4gPiB2MS0+djI6DQo+ID4gICogTW9kZWxsZWQgYXMgYSBzaW5nbGUgUFdNIGRldmlj
ZSBoYW5kbGluZyBtdWx0aXBsZSBjaGFubmxlcy4NCj4gPiAgKiBVc2VkIFBNIGZyYW1ld29yayB0
byBtYW5hZ2UgdGhlIGNsb2Nrcy4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZmQvS2NvbmZpZyAg
ICAgICB8ICAgNiArDQo+ID4gIGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAgfCAgIDIgKw0KPiA+
ICBkcml2ZXJzL21mZC9yei1tdHUzLXB3bS5jIHwgNDA1DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gDQo+IFRoYXQncyBub3QgYSBNRkQgZHJpdmVyLiBUaGF0
J3MgYSBQV00uIFVzZSBwcm9wZXIgc3Vic3lzdGVtIGFuZCBlbWFpbA0KPiBwcmVmaXguDQoNClNl
ZSBbMV0NClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVu
ZXNhcy1zb2MvcGF0Y2gvMjAyMjEwMDYxMzU3MTcuMTc0ODU2MC0yLWJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tLw0KDQpJdCBpcyBhIHNpbmdsZSBkcml2ZXIgdGhhdCBiaW5kcyBhZ2FpbnN0ICJy
ZW5lc2FzLHJ6LW10dTMiLCBhbmQgcmVnaXN0ZXJzIGJvdGggdGhlIGNvdW50ZXIgYW5kIHRoZSBw
d20NCmZ1bmN0aW9uYWxpdGllcy4gSnVzdCBsaWtlIHRoZSBjbG9jayBkcml2ZXIsIHdoaWNoIHJl
Z2lzdGVycyBjbG9jaywgcmVzZXQsIGFuZCBQTSBEb21haW4gZnVuY3Rpb25hbGl0aWVzLg0KDQpJ
dCBpcyBzYW1lIGhlcmUsIGEgc2luZ2xlIE1GRCBkcml2ZXIgd2hpY2ggYmluZHMgYWdhaW5zdCAi
InJlbmVzYXMscnotbXR1MyIgYW5kIHJlZ2lzdGVycyBjb3VudGVyIA0KQW5kIHB3bSBmdW5jdGlv
bmFsaXRpZXMuDQoNCnJ6LW10dS1jb3JlIGlzIGNvcmUgZHJpdmVyIHdoaWNoIHByb3ZpZGVzIHJl
c291cmNlcyB0byBjaGlsZCBkZXZpY2VzIGxpa2UgY291bnRlciBhbmQgcHdtLg0KDQpJIGFscmVh
ZHkgY29waWVkIFBXTSBzdWJzeXN0ZW0gaW4gdGhlIGxvb3AuIEFtIEkgbWlzc2luZyBhbnl0aGlu
ZyByZWxhdGVkIHRvIFsxXQ0KDQpDaGVlcnMsDQpCaWp1DQoNCiANCg==
