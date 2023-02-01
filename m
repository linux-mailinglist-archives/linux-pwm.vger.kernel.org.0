Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27029686FCA
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBAUmF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 15:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBAUli (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 15:41:38 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56179C89;
        Wed,  1 Feb 2023 12:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7ZjKLN1MTLlGe2xx8skkZSV9TQEGwRI+XXTGekdaCieXGsRaEry/iGYmwbScgXbhDGGiil+yOjlflpsycJGLiZhUWO57SFEinkGx3rTG+Q2dNVsHOA6glJVs6VKUmnnUEUPCC3nI3Rz+7wNQ9BMSeSmFIL6Uy3l11n/kQ5YFLkCEa9e+GcMscx1hCdH3UyB1tEzUegBF1S1/pN7bkvvYyDOI2cRFUjN7KSNy3Ccxh1yb0h7KRrSTZyXINauCR+Z7/5IyyuutzUPJqroPBtnkNBcyGoQBa8h4xBYWTOqH2kRG0AhHk9M9iM3/pENKNPMntXp5gw7ZCGF+hOIVCjpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHVKcn71sOHpf60w1rGmVqZGQG/MURU8ab/5AfuFQ14=;
 b=UN1r80U/3SZ505oR0rmJAOWYuX+Ae7NXHsI7gjsPSueVFTQ2bO0QPOzE0tuZ5nSHH2zFJjkpaBEi9n/QiBJZF/zq7J6+MoLXAi3cF5jSGzIOuVY8C7/CeMeJRgGhu8on3LJWLUINY7dK7khTC0egcK0dYUk4LKQKuEXMmBtV2P4YANKkmUAmLXr+ZBpZ8dyIS1laHC73CVnY3RoCWmtPQWfalBgt/ILQRjAAYh+62HcPUiXMSBS6TElirAh0e7nat4Nvmw6cjdDKe/ePGiXykU0Sn7uEpZtZBbuQ/y/UIDTS5gQc1nLYoN3/3+3Pnxranbh86sqMCkf2EHJXmZz6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHVKcn71sOHpf60w1rGmVqZGQG/MURU8ab/5AfuFQ14=;
 b=AYAaDU7JVIvFELPAkRzczXoOMte8BOHovo/LxL20ZV7QY2ouRckvrQkYZDzKZ8uyyznNhpoDr5+DaNWCmet6Zl2PfSDGumtF0HCD8PooWa8MwjKGJwsTxmIu+SnCNwCox+TKzHCLYYspAxZ+3XC2II8NhU9J1ll92SPjqerfRBg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8012.jpnprd01.prod.outlook.com (2603:1096:604:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Wed, 1 Feb
 2023 20:41:18 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 20:41:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v3 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZDyTrx1aPUVR9Qk+gIxiBq8WX966nvBuAgBMfisA=
Date:   Wed, 1 Feb 2023 20:41:17 +0000
Message-ID: <OS0PR01MB5922E6F023F223AC4DB944AF86D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
 <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
 <20230120163525.rhtgexzmizotnvrg@pengutronix.de>
In-Reply-To: <20230120163525.rhtgexzmizotnvrg@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8012:EE_
x-ms-office365-filtering-correlation-id: 9a3f9c73-b992-4dbd-cc59-08db0494ab58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yc4QkzXaIQ59ugkyA0p8WqGT6/7mklBh3kI3vS8h+LIQZnvNYGFVr7rAOiXC8L2oasmPPxlBO/bql1Xvi6oLxrQHuJ+R9OwcwJsdKYFRwiQfQHAPeaHAX059NgO4jw3/T5fDjHFGvR3zHHVNh+X6z9fLukcjY7k/4W2ZOC+vRy90zJN0GD2wEeK9uRxTdzKCULq7/Vvpcgz1GolgIuMdO3UuhCgQmLp1+OJwIbZIBDfXH68bYFqeZWngpupcmOvGCVKC4XS7pdkPLRl4hNk8UQ1qKFdemG0YIzidJWDTpNiVhmr/4a8Cy71jxeDxTG19yfHhl52HyumQtYUa6w9iyMlGbL+U5O49NRa5FPvWUTy4EaysE6gV0CpO2qMtg+Emhn17Z65zlMqQqOEZmboKbRJpGAi2Mo+6Z0mmbGKicSZ//099hnLY26AyIBqK4HXpmU8eD9ieXvhjpmpAp76ZENy24q72vXf1ws23r1ZfzkEd4Gl56EuzAYlajxiSO/U4ar1XGV2u18iAQf+loTBrC1hPUTATQeIoGyp3cr7N5jSeX03CGmV2iYZ8/8j/Ig5a313BuQHbQII3vOIKCACQEaf9ECRmm/ac8XV0/aDwYQJD9T93sSWiQBuydVGMFqPf5zGbBrM3jAVJJaw3HEadeSxKKd/uOSg1SG96wnj3tNoeceMHxWCuLv4LCiY6RZrXvHktIrSsDZoMgszqSIXgNIM6w4zgTJJ4irWng7JH8x0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(9686003)(33656002)(52536014)(64756008)(66476007)(66556008)(66946007)(66446008)(71200400001)(8936002)(5660300002)(122000001)(8676002)(76116006)(4326008)(6916009)(86362001)(186003)(83380400001)(6506007)(26005)(478600001)(966005)(2906002)(7696005)(38100700002)(54906003)(41300700001)(38070700005)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmkyeit4V0JtaWpkNGg0dXpWNElYL2hINVlUajRwOE52b0ZOR1FlcFdTaEdn?=
 =?utf-8?B?MDZGSElCVnZUU3ZqWEhqY0xBQnZlZFJidmwxYlJCMzFYNkE2ODA1NndqbXo3?=
 =?utf-8?B?dkxDV3NNZVlseHU2bnlmOERlZ2ZFTjNDMGc1ZS9taHdCNjVMMCswUmtEdExK?=
 =?utf-8?B?TWZxSmNxRkhERXg1Y3NpR2RGTTkwU2QwVkZCSG80WmFySEN3WWFtWVhEKzVM?=
 =?utf-8?B?WFhBWTFxUGNqNnlTYnRPL2dCQ1V5NlNOYlIvdHc1RElpdXFucDJiYmJ0Zkls?=
 =?utf-8?B?YUhIc2crbXR0QUhpY0djYkJJVU96MWZCNzQrWTh4ZWpQWEk4M2pTandjVWh6?=
 =?utf-8?B?QkpJL3VERDAvWE5BZ1RxOEQzUUdsWG5GQW83NzVtaHZtd0Ixb20rS0xzNTZC?=
 =?utf-8?B?MkVIQnZqV0lFOUcvN2xZclN1NWZYcFQ5T1NJMkFDc2dHQlIwdE1IK0JjRlRZ?=
 =?utf-8?B?aGVJdnN0c1ljTktPSm12bW5FVEQxWXJJQldsRWtFMVZOZ3VocEtSZHNHQzFt?=
 =?utf-8?B?dkRYVkcweFhDdTkxYXdLL0hnSk1tUGhuQzU2WEx2cFlrSmsxanlZWHFDZXhW?=
 =?utf-8?B?UE8yclZwQzFHQXdxdkJlQ0VWTmt5c1MrNGp4TWR6ME1vUGp6VE81RmgwTE14?=
 =?utf-8?B?VjZTVmFBM1RST3RZbjVWcnNUM0tCL0tSQkZoYjZXT29HTTdyMlZXVmRZY0Zv?=
 =?utf-8?B?SStwem1VbUhaZ3YwbnhpUUdyOWNycVZzcHgyajhheE11eTFjeVBkZUQ0YzU3?=
 =?utf-8?B?eDAyWlcyRTc4b1c1STdIdFYxS0paeWdKbFErU0tkVDBtQThWUEdBWXh5YlpQ?=
 =?utf-8?B?dXZpd2pNQmhNZkdFUjlwd0JSRXFBbVFxS0QrMnFSUnN1cVViNnI5bnA3WDlt?=
 =?utf-8?B?NE1HdWEzQ012RHlyQ3JNKy9DWmRaWUdsWjZ5S3p1enZOQVJ4UDV2SlMzc1JO?=
 =?utf-8?B?V3NpQkQzcmI5QkZCdUpIMEJtQ1Fjb3pXVFFmYm1SZEpJMjl0TjRVeFpzNm1P?=
 =?utf-8?B?TEtRcktLNHRLTW0renZwVjAxRmg5VzdDMWh6azhYdmVKbFZ6TXd0aEhiY0dC?=
 =?utf-8?B?enpHTytoWXVYVy9mWlNPM0hIYjE2WHh2VXFTNXMvZVBuZ2t6NGk5RlFrcnBU?=
 =?utf-8?B?MzlXdzdsQVh6VmlzMXY5bWMwemVsUFJybThXcHF4akw1eVRLYVBCZTBWY2Ju?=
 =?utf-8?B?eDNDblh5TW1menlmdUpXNGF3dVZlRm15dDFhNnZrM1JudldYTm1wSlgxNitP?=
 =?utf-8?B?VGM2NUtzakgxWGZKSWJPUDZJWnJtWGtLK2FMV1lIdVp3VnhEZ09TWWN5dThp?=
 =?utf-8?B?N25vTURwS2U4b013RzJoczk2K0haSkxwTi9XTnNtalNxWUZWdlVZYklLNTYv?=
 =?utf-8?B?aGFrNnFkNU40U09tMkhwQXVJbzBzSXZ6YnU3QVRLaUU3YWZIY1F5T1lieE5p?=
 =?utf-8?B?d3k1KzR4NnpSVk1HRXRHZzEyUWc3Wkpib2U5ckRHWkgzRmRhckFUSTFibkU3?=
 =?utf-8?B?N3M2TVJMVkk1b1hDRlhwdVE4eXcxV2tObHBRMVEzM09DdW1pUHRhM3JzRjBB?=
 =?utf-8?B?b2wwZGl2aENTQXZ1TVd0blJtczg2V1V3eGdnYWVTZFIxS0dJQTVIWVBhRnRj?=
 =?utf-8?B?NHY2VlBqYlRicEp3NmozSkJ2NjE3cmc0UGpFT0VseVFVSWcvVVhUaEZDdGYx?=
 =?utf-8?B?cUMzb3JKb1ByU2RnemhZZGFkOE8wb1F2NWxUSlpSUnhuRmEzbWlmRitzSS9R?=
 =?utf-8?B?NnN6TW4rSC8wMHdtZExneDJRZnhFR0d1a0kvandkRVFWczNXOXUzYVFieU9k?=
 =?utf-8?B?WWZEdjJIN213UTA3a0NFUThUOGhtN2dDcWVQM3FoZGEyTmQxaU1tOHd1Y3Ew?=
 =?utf-8?B?Rm8xQURGQ01hdFpOeEtxZjVrRnNmbXlFeWFuVlZodk9hUWRoVDBEVlFpWkFx?=
 =?utf-8?B?aUlaU0tEVjRxem1mZk80U2xSSW9hWU0rNGNkYW5kSGpCb09POU00QmxaMjNL?=
 =?utf-8?B?dnJkUkRsc1gwQkVJYnZGN1F5UmNqdGVDU1pkNjkvUW1PMnNxcG1MV2FIK2FT?=
 =?utf-8?B?L240LzFPV3A3VEdldjlmc0EvNWpSdHdKQW9NNnFtanBFYk42eXNSZHphQ2RK?=
 =?utf-8?B?UUFPYytpK3JFb0hoTll5MGJPWDZvUWVybHZsUUpzVUttVUc4aE9wZTR5TUg1?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f9c73-b992-4dbd-cc59-08db0494ab58
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 20:41:17.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuCygW6VaTOPFU5qATwv4EcvabS6LqRLQzuPPFqcmatNUSEZCNi+eoBSo+MuOCp6D6oYuYZPU5K6oCnThqmpWlJ1cy0zV7+qrudDOIxzsG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8012
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDIvNF0gcHdtOiBBZGQgc3VwcG9ydCBmb3IgUlovVjJNIFBXTSBkcml2ZXINCj4gDQo+
IEhlbGxvLA0KPiANCj4gPiArICoNCj4gPiArIGh0dHBzOi8vd3d3LnJlbmVzYXMuY29tL2luL2Vu
L2RvY3VtZW50L21haC9yenYybS11c2Vycy1tYW51YWwtaGFyZHdhDQo+ID4gKyByZT9sYW5ndWFn
ZT1lbg0KPiANCj4gSSB0b29rIGEgbG9vayBpbnRvIHRoYXQgbm93LCBhbmQgdGhlcmUgYXJlIGEg
ZmV3IHRoaW5ncyBJIG5vdGljZWQuDQo+IA0KPiBUaGUgUFdNQ1lDIHJlZ2lzdGVyIGRlc2NyaXB0
aW9uIGhhczoNCj4gDQo+IAlUbyBjaGFuZ2UgdGhlIHNldHRpbmcgdmFsdWUgb2YgdGhlIFBXTSBj
eWNsZSBzZXR0aW5nIHJlZ2lzdGVyDQo+IAkoUFdNbV9QV01DWUMpLCBzZXQgdGhlIFBXTUUgYml0
IG9mIHRoZSBQV00gY29udHJvbCByZWdpc3Rlcg0KPiAJKFBXTW1fUFdNQ1RSKSB0byAwYiBhbmQg
c3RvcCB0aGUgY291bnRlciBvcGVyYXRpb24uIElmIGl0IGlzDQo+IAljaGFuZ2VkIGR1cmluZyBj
b3VudGVyIG9wZXJhdGlvbiwgUFdNIG91dHB1dCBtYXkgbm90IGJlDQo+IAlwZXJmb3JtZWQgY29y
cmVjdGx5Lg0KDQpPSywgSSB3aWxsIGZpeCBpdCBpbiB0aGUgZHJpdmVyLg0KDQo+IA0KPiBUaGlz
IGlzbid0IHJlcGVjdGVkIGluIHRoZSBkcml2ZXIuIFBsZWFzZSBlaXRoZXIgZml4IHRoYXQgb3Ig
YWRkIGEgY29tbWVudA0KPiB3aHkgeW91IHRoaW5rIHRoaXMgaXMgbm90IG5lY2Vzc2FyeS4gSWYg
eW91IGNob29zZSB0byBhZGhlcmUgdG8gdGhhdCwgYWxzbw0KPiBub3RlIGl0IGluIHRoZSBMaW1p
dGF0aW9ucyBzZWN0aW9uIHRoYXQgSSBhc2tlZCB5b3UgdG8gYWRkLg0KPiANCj4gSW4gLmFwcGx5
KCkgeW91IHN1YnRyYWN0IDEgZnJvbSB0aGUgY2FsY3VsYXRlZCB2YWx1ZSBvZiBQV01DWUMuIFdo
ZW4gbG9va2luZw0KPiB0aHJvdWdoIHNlY3Rpb24gMTcuNCBGdW5jdGlvbiBEZXRhaWxzIEkgZG9u
J3Qgc2VlIHRoaXMganVzdGlmaWVkLiBIb3dldmVyIGluDQo+IDE3LjMuMi4yIHRoZSBmb3JtdWxh
IGlzIGFzIHlvdSBxdW90ZWQgaW4gdGhlIGRyaXZlciAoaS5lLiBQV01tX1BXTUNZQyA9IChQV00N
Cj4gcGVyaW9kIChucykgLyAoUFdNX0NMSyBwZXJpb2QgKG5zKSDDlyBEaXZpc2lvbiByYXRpbykp
IOKIkiAxKS4gQ2FuIHlvdSBtYXliZQ0KPiB0ZXN0IHdoaWNoIG9mIHRoZSB0d28gaXMgY29ycmVj
dCwgbWF5YmUgYWRhcHQgdGhlIGRyaXZlciBjb2RlIGFuZCBub3RlIGluIGENCj4gY29tbWVudCBh
Ym91dCB0aGUgZGlmZmVyZW5jZT8NCg0KSSBnb3QgY29uZmlybWF0aW9uIGZyb20gSFcgdGVhbSB0
aGF0IGJlbG93IGZvcm11bGEgaXMgY29ycmVjdC4NCg0KUFdNbV9QV01DWUMgPSAoUFdNIHBlcmlv
ZCAobnMpIC8gKFBXTV9DTEsgcGVyaW9kIChucykgw5cgRGl2aXNpb24gcmF0aW8pKSDiiJIgMSkN
Cg0KDQo+IA0KPiBBbHNvIGNvbW1lbnQgd291bGQgYmUgbmljZSBhYm91dCB0aGUgZmFjdCB0aGF0
IHRoZSBuYXRpdmUgcG9sYXJpdHkgb2YgdGhlDQo+IGhhcmR3YXJlIGlzIGludmVydGVkIChpLmUu
IGl0IHN0YXJ0cyB3aXRoIHRoZSBsb3cgcGFydCkuIEkgZGlkbid0IHJlY2hlY2ssDQo+IG1heWJl
IHRoZSBpbnZlcnNpb24gYml0IGhhbmRsaW5nIG11c3QgYmUgc3dpdGNoZWQ/DQo+IA0KPiBBIDEw
MCUgZHV0eSBjeWNsZSBpcyBvbmx5IHBvc3NpYmxlIChhY2NvcmRpbmcgdG8gRmlndXJlIDE3LjQt
Mikgd2l0aCBQV01MT1cNCj4gPiBQV01DWUMuIEFzc3VtaW5nIHRoaXMgaXMgY29ycmVjdCwgdGhl
cmUgaXMgdGhlIHByb2JsZW0gdGhhdCB0aGUgdHdvDQo+IHJlZ2lzdGVycyBoYXZlIHRoZSBzYW1l
IHdpZHRoLCBzbyBpZiBQV01DWUMgaXMgMHhmZmZmZmYgYSAxMDAlIGR1dHkgaXNuJ3QNCj4gcG9z
c2libGUuIFNvIHBsZWFzZSBzdGljayB0byBvbmx5IHVzaW5nIHZhbHVlcyA8IDB4ZmZmZmZmIGZv
ciBQV01DWUMuDQoNCldpbGwgYWRkIGJlbG93IGNvZGUgdG8gdGFrZSBjYXJlIHRoaXMuDQoNCgkv
Kg0KCSAqIEEgMTAwJSBkdXR5IGN5Y2xlIGlzIG9ubHkgcG9zc2libGUgd2l0aCBQV01MT1cgPiBQ
V01DWUMuIGlmIFBXTUNZQyBpcyAweGZmZmZmZg0KCSAqIGEgMTAwJSBkdXR5IGN5Y2xlIGlzIG5v
dCBwb3NzaWJsZS4NCgkgKi8NCglpZiAocHdtX2N5YyA9PSBwd21fbG93ICYmIChwd21fY3ljID09
IEZJRUxEX01BWChSWlYyTV9QV01DWUNfUEVSSU9EKSkpDQoJCXB3bV9jeWMgLT0gMTsNCg0KQ2hl
ZXJzLA0KQmlqdQ0K
