Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088A7B9FD8
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Oct 2023 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjJEOaP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Oct 2023 10:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjJEO2u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Oct 2023 10:28:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::707])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F81FEF8;
        Thu,  5 Oct 2023 03:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG103UzvkQ0Brf6CV831tKWTCwNZbD/+74WnMP2ljkE3uqIN773BZAXD40onI3vuOELSt2I4qrcEO6Er860IkIoFVxy+Fg1Fn5Gu3HbVcXLQ0qkW4M+gGZNhfOB7sNgTk9KujkGiM1YABgE8mlffwbyvYOHeObKgFdqZw3W5MpoNWD74pwfrhJw86/r7OanjsqFzD1NifRKcBPteBoUKkBzh+s0kT1fw4vKsga2KALOudSQzyujWm1CySpwMTJCH1n9VmDBx3LZv7h+zJ7sb/NGsD6JFgskrmF0ooCP484wSuYhzjRtJXUvr4hTTvbsB+C8r4ywaSyk8dGyfu0qSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3++QxBe6LvkVhFUEGDqNVuc3Q5nG1/iv1pjH+w0xIg=;
 b=P/S1/dZOf0Bx359Dw7pjRXgF5KVn9lifhJnAKQnxUPOGz9KRQ0lhLPrt2j0P5N/qAtRfulxDNY1BatLMCBxSzvMd7wN7d6ecnxqEwdNloPIzERJQaXeaXdsLsVIBa5u2NDRwsL72J3a+/Kfv5lqbwXbotkZNR7Q2tKN1elxFtVBmHyfocU7C2X878ZCejRiN/87sXAo8GUdLbQWYO6Pdn6qXFELrDGjGW98iEVLlA1ueclXTu6fv5D6MaIDebHahcdLtvPD1CyACw1InAHtZWLps5kelnqjDPeAr8GlK9ZtnDfr0TYuYrvnayDaZxUoIJqW6qGgFodxjXr30dowTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3++QxBe6LvkVhFUEGDqNVuc3Q5nG1/iv1pjH+w0xIg=;
 b=Le2bIkCLAwyMkXgWsDYkfHLSqg6x/ynuku7nOd+CqPB5InxrW0IfcL7z4gr3dlXPQjqxtcs86if+WiEaZQ4ugfHUIf9MNYqFF6isAKVz49RWbwjd/1dfWbE64XauwRpOJ9Zox6TKVwn3EY6bno28N5a5h2G1NdllY0/75QuGeXs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8625.jpnprd01.prod.outlook.com (2603:1096:400:159::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 10:11:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:11:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZ9rQMFWDsgVRgWEOut3JS4AjEP7A670MAgAAJxSA=
Date:   Thu, 5 Oct 2023 10:11:43 +0000
Message-ID: <OS0PR01MB5922361A43B64459329BE77C86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231004111451.126195-1-biju.das.jz@bp.renesas.com>
 <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
 <0f6723d8-ff2d-4b7f-b007-6ee515315184@kernel.org>
In-Reply-To: <0f6723d8-ff2d-4b7f-b007-6ee515315184@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8625:EE_
x-ms-office365-filtering-correlation-id: 996e6a8c-9d96-4dac-d4e3-08dbc58b79e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WC5VUTQku/oAUuselsI6rGTASWQfoADoV5NRgZYQ+/CGnnE4G73tuxikP/QYQDEvkdLRzfvJy9DRokKZLH3aBb1pT2QuAJxPe/XoH/R+gjPN8Kbmw1itQJg4Nn2w32Nf1KhdM9ZD8FCqTjICwJK2rLKpV7Nij6sHJVsg+BFhBuUdhimC6Q7MKWsrcJ3z4afSxhQ0j+kHVAW4NRzHiuNy4mKi2XSLDOOcCvQ43QcISFDkIVOmZ5rAdk4okGbpp5aCGQjAwe+YJGSWfLcM28r5hifhhvVtji3YaujqoKjGQMtyFTGvOoM3o7e1Q0S4aCdoxBXkcJl4NUpF7BwBjKIQSvzLmNzBXaQXC7Vz0M+0WUHXYJlGdFtH9HsxP9bJF/F+qngyb6l3Hm1EZoooMluJv5TgIZp877QfHRxgXo7sK9Ic+QYYaV+LVyTjXIZnKwElCHvY9KyvKYqSvF7e6gLYgzWfVXrANFQXawrl4lV5c2w+HLcKtM3d9RDzcme7PLGYhgBYgvqq/+g5cGG4DtBXsq/GSpppv51Yw0vVIqx6nCPyzO6ukcndFE/TrQtSy8PYGgWrTNcdzlpzNDTniM0TomWqJ1POviyInc/q328L/8eGsURP1oDd+m/ARWfVefol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(9686003)(6506007)(478600001)(7696005)(53546011)(71200400001)(2906002)(26005)(8676002)(76116006)(110136005)(107886003)(41300700001)(33656002)(54906003)(66556008)(52536014)(4326008)(316002)(66476007)(66446008)(66946007)(64756008)(8936002)(5660300002)(38070700005)(122000001)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJ4bFgwVktKWERiRDBhZzBLSUN2WjMvbVgwa1JKOUNxaS9oNEhyQ0FJanRz?=
 =?utf-8?B?YjJPWnloTzVUSy9YTEJmUTZVY1UyeGdSUGtkcmRmb0NyUEZ6dE1wYndVQUxF?=
 =?utf-8?B?b2JDSnlVRXFoYlQ0VGhZc0FPK1Q1U3dJL2gwa1hhNWZzdUYvd0JveG02eHdJ?=
 =?utf-8?B?eEducFlvL2RKd2RjY1B6amFkaGx5cHBUdWt4ZUJDNjJ5Rk1rU2dDVnBzQlpx?=
 =?utf-8?B?eUZTTXhRVHhUUEgwQ3UxNmppNmhhc3J2SWVNa3AzV0FnSTVlKzcxRlJybWZI?=
 =?utf-8?B?N3pRVW5RVXZYTGxLYUZmV3A4dnBqcmlTVkwrbmJqNDNpamE3N2p1VUZTRm5m?=
 =?utf-8?B?bjVmdkgyelJmZDlIanJRdjJ1Ums5aEpob29ZUFNodGVwOVIrMTBBVzVSUmJX?=
 =?utf-8?B?NnJralpSaGxOU0tLQWxydTZYTmxCVVBBeVpQZHNMOFU5R0QyQ3RRcUJIRTJG?=
 =?utf-8?B?VHpaNlJNRVFzRVVDQ1ErVG56OVkxRnhtRHhpWTFEdzBzNkR6d1hsdmVsUVI4?=
 =?utf-8?B?N1MvNjJicnRyNXRZWjZpbExjZWcxdGMrMFZDM3ZtejM2dWtEZ08wdTZXT1Nh?=
 =?utf-8?B?WHRjSHdxd2gyNjZLbm9tVGJjMjBIWDlDUlFrdmJtbmQ1Z2ZleHA1am1qWktI?=
 =?utf-8?B?YU9Qako5RWcrMU56ZEE3b1NQSEtTMkpveU8vNDJFYVJJNzBoc2RiZXlyWnM0?=
 =?utf-8?B?dXU2b0xVWEVmNytFbW1jejFWNitRbUY3UjhNaVhXSVdoQkxVTkNucWJ0VEhP?=
 =?utf-8?B?WnNJTEU3NTZCRHcxanhyVVN5aHZUdGVIQTJMc3RZZzVHNmFzZTlPeW1CWW1S?=
 =?utf-8?B?SEUzWmFZV0didytJRWt1Z0p5UjFrZ0lrWEhJaWpSK2F4TFFQUjN2dythYVBD?=
 =?utf-8?B?UExhVU1NVVBqNkRNcUhzWGxoMXpRaG8xMWRySXVUZVM2dEpwQ0FKeGZwRXBQ?=
 =?utf-8?B?STFJcXpmMmdXZEtFNVQxZ0d4RWc3UFAvK2dxRkNPY0dvankybHo5WVcwRGpo?=
 =?utf-8?B?WXdMQ0E4cjU0ZjVkMEYzS2RzV3d1bXBFeHVoRzhlZjFmV0E0WllVMDJTVy9i?=
 =?utf-8?B?M2pWZzk4TmNjMXhpVTJHM3loK0ZCU1VOZm5DWk16NWJvOEc2ZFlSN3M2TjZj?=
 =?utf-8?B?b3VEQUo3VTFFMnI5T25KaWlMakdNUnVaTzF5Szg1ZGtyYVp4Uk9ZbVd0bi9S?=
 =?utf-8?B?UEFzRDRUR0IwZGVDc29ZS254bElrYTZMM1lzWnRsQXRlWEdUdDFzUkNuZTgw?=
 =?utf-8?B?My9vKzJHT05vQUdKV3QvVm5OSmRQRzRFOG5VZk1CQ3RWS1RjTmgrVG03ZnpN?=
 =?utf-8?B?QjJ6V0ZoWmsxamRYK3Y4YTJ0SzlYQlRZODlDdVg4MnZVS0dzRTZQbEVnZVFo?=
 =?utf-8?B?eW9nUHB2NCsxMlh4K0grTk9HY3Rmb21lQ1k2OXlSbDczQWlBaFA4a3hNd20v?=
 =?utf-8?B?cDFuK3dtOEFXTHRjVVZQcmZUNW5aTmszcm5GSkx4MVJGaDArc093SmVJd2NB?=
 =?utf-8?B?UTBNKzlGV095ZHJLVXZHSWpvSHBSQlZPWjNhaHcxdHJEUjNGNEdVeXRFQnhE?=
 =?utf-8?B?RjN1RG5WVE94QmVQcVdsRDRDeGY0akkzenI3ZERFZGpscUJJamZsYythcGFY?=
 =?utf-8?B?dlMweTJJT1JYMFhRTFlRN2x5MXVwbUpaZkYrbTRIRGUxc2NVL3p5ZE00Sklm?=
 =?utf-8?B?eEVndFo3Uk04djJpUnZQd0RGUjdaVlk4bklSN1IvVVdRZG9rYVBBUnlqRmdp?=
 =?utf-8?B?d1NJRUFtUXpFQytHaWpFSWpiVmxvODFKMkNrU3o4QWFhYVlIM3d0OHlQN21Z?=
 =?utf-8?B?aUJSaU1wK1p5aFVvQU52SFFkUEI1ZGFXTStaOElZbElpejFmbXYycVJ5ZW5E?=
 =?utf-8?B?dkk3emRsNnFnVVRUYnkzVWpIb3lrdlhPdFFHNEtNa3p4dFloYzl1OGU0MzNU?=
 =?utf-8?B?L3kzVmN2cFRaSmFMZy9TekgzeGF2K21LdWF1a083Ulp4aFRPdkpseTlRSUpD?=
 =?utf-8?B?cUZzelgyNFo4emJLVFIycTFScEZqMEVib0JnNmRGZTZ5TUdqWGhPTE9aK05Q?=
 =?utf-8?B?djBlQkF6eXJhOXFGMTFkU3paekVQUHBpVm4yMlAwWTVYbUdOUlFzSmI5bUVp?=
 =?utf-8?B?RU1oc1pBSTRhOCtXaGNlb05Nb2pETGR4NExpOVR4cU9kazBpUldOTm92OC9q?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996e6a8c-9d96-4dac-d4e3-08dbc58b79e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 10:11:43.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diKEcFc+hBN8GXjuXjrxUCkf1Uq+FfC5VLaX2+HH3p6CBr/LliM6WiBtgqgVh/sRDiNAR6FFId7akkQhDB8M94kDcBpdHu8yFMXtZqq4pgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8625
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MTYgMy80XSBwd206IEFkZCBzdXBwb3J0IGZvciBSWi9HMkwg
R1BUDQo+IA0KPiBPbiAwNC8xMC8yMDIzIDEzOjE0LCBCaWp1IERhcyB3cm90ZToNCj4gDQo+IC4u
Lg0KPiA+ICsJcmV0ID0gY2xrX3JhdGVfZXhjbHVzaXZlX2dldChyemcybF9ncHQtPmNsayk7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gZXJyX2Nsa19kaXNhYmxlOw0KPiA+ICsNCj4gPiAr
CXJ6ZzJsX2dwdC0+cmF0ZSA9IGNsa19nZXRfcmF0ZShyemcybF9ncHQtPmNsayk7DQo+ID4gKwlp
ZiAoIXJ6ZzJsX2dwdC0+cmF0ZSkgew0KPiA+ICsJCWRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwg
LUVJTlZBTCwgImdwdCBjbGsgcmF0ZSBpcyAwIik7DQo+IA0KPiByZXQgPSBkZXZfZXJyX3Byb2Jl
DQo+IA0KPiBPdGhlcndpc2UgeW91IHJldHVybiBzdWNjZXNzLg0KDQpBZ3JlZWQuDQoNCj4gDQo+
ID4gKwkJZ290byBlcnJfY2xrX3JhdGVfcHV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qDQo+
ID4gKwkgKiBSZWZ1c2UgY2xrIHJhdGVzID4gMSBHSHogdG8gcHJldmVudCBvdmVyZmxvdyBsYXRl
ciBmb3IgY29tcHV0aW5nDQo+ID4gKwkgKiBwZXJpb2QgYW5kIGR1dHkgY3ljbGUuDQo+ID4gKwkg
Ki8NCj4gPiArCWlmIChyemcybF9ncHQtPnJhdGUgPiBOU0VDX1BFUl9TRUMpIHsNCj4gPiArCQly
ZXQgPSAtRUlOVkFMOw0KPiA+ICsJCWdvdG8gZXJyX2Nsa19yYXRlX3B1dDsNCj4gPiArCX0NCj4g
PiArDQo+IC4uLi4NCj4gDQo+ID4gKwlyemcybF9ncHQtPmNoaXAub3BzID0gJnJ6ZzJsX2dwdF9v
cHM7DQo+ID4gKwlyemcybF9ncHQtPmNoaXAubnB3bSA9IFJaRzJMX01BWF9QV01fQ0hBTk5FTFM7
DQo+ID4gKwlyZXQgPSBkZXZtX3B3bWNoaXBfYWRkKCZwZGV2LT5kZXYsICZyemcybF9ncHQtPmNo
aXApOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+
ZGV2LCByZXQsICJmYWlsZWQgdG8gYWRkIFBXTQ0KPiBjaGlwXG4iKTsNCj4gPiArDQo+ID4gKwlw
bV9ydW50aW1lX2lkbGUoJnBkZXYtPmRldik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
Kw0KPiA+ICtlcnJfY2xrX3JhdGVfcHV0Og0KPiA+ICsJY2xrX3JhdGVfZXhjbHVzaXZlX3B1dChy
emcybF9ncHQtPmNsayk7DQo+ID4gK2Vycl9jbGtfZGlzYWJsZToNCj4gPiArCWNsa19kaXNhYmxl
X3VucHJlcGFyZShyemcybF9ncHQtPmNsayk7DQo+ID4gK2Vycl9yZXNldDoNCj4gPiArCXJlc2V0
X2NvbnRyb2xfYXNzZXJ0KHJ6ZzJsX2dwdC0+cnN0Yyk7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCByemcybF9n
cHRfb2ZfdGFibGVbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyemcybC1n
cHQiLCB9LA0KPiA+ICsJeyAvKiBTZW50aW5lbCAqLyB9DQo+ID4gK307DQo+ID4gK01PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIHJ6ZzJsX2dwdF9vZl90YWJsZSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciByemcybF9ncHRfZHJpdmVyID0gew0KPiA+ICsJLmRyaXZl
ciA9IHsNCj4gPiArCQkubmFtZSA9ICJwd20tcnpnMmwtZ3B0IiwNCj4gPiArCQkucG0gPSBwbV9w
dHIoJnJ6ZzJsX2dwdF9wbV9vcHMpLA0KPiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IHJ6ZzJsX2dw
dF9vZl90YWJsZSwNCj4gPiArCX0sDQo+ID4gKwkucHJvYmUgPSByemcybF9ncHRfcHJvYmUsDQo+
ID4gK307DQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIocnpnMmxfZ3B0X2RyaXZlcik7DQo+
ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+Iik7DQo+ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06cHdtLXJ6ZzJsLWdwdCIpOw0K
PiANCj4gWW91IHNob3VsZCBub3QgbmVlZCBNT0RVTEVfQUxJQVMoKSBpbiBub3JtYWwgY2FzZXMu
IElmIHlvdSBuZWVkIGl0LCB1c3VhbGx5DQo+IGl0IG1lYW5zIHlvdXIgZGV2aWNlIElEIHRhYmxl
IGlzIHdyb25nLg0KDQpPSywgSSB3aWxsIGRyb3AgaXQuDQoNCkkgYW0gd2FpdGluZyBmb3IgcmV2
aWV3IGNvbW1lbnRzIGZyb20gb3RoZXJzLg0KDQpJIHdpbGwgc2VuZCBWMTYgYWxvbmcgd2l0aCB0
aGVpciBjb21tZW50cyBpZiBhbnkuDQoNCkNoZWVycywNCkJpanUNCg==
