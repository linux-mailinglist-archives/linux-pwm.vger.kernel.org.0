Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308D5EE584
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiI1TYQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiI1TXu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 15:23:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20708.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::708])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF010B225;
        Wed, 28 Sep 2022 12:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIp3PHAHcAtGzWEAcP/ovyQ1Aav+UTHP+arFNd3uUhELPfHXNwIqgga2fNGkHbV3P6aIU6pCvuW55KKoltOgiPzWT0jP6ysptA9YwcH8MC+67mXV/xoo1k2iQFaNG48vvrdRW6Gsgk7g+AxZrp4DMNQJnCdNKD0CFZIJ5ec5zwEc27XdLCQulET8CYLyeNeGxMfmfHDFSR0ptblgFCPjFOEFKxEm1fMOcZ99ARMVy1GuE55yT95NwQQeP53MWnMwUZMt6J+Di079kzCjg/yb7RlhohVuyBKyVaFn0O0l4IWVm/UHpGj0aFAnzbzfhAYOAQf2+m2H8ByUlEfvcNoH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GQ+wK9A2cB7lwZOLCeofhhy0WCyOssWj8lMJWIbDDE=;
 b=UQ/T1jE6grvJ8YQuZsVsPH0vzQrpDY0wljr4iCTE97BHcH6jxAUDuC8L4T9qI0ce4i7352lLHXZqbA7CRdRs//R18BN9945QsTbDRRzj/quiEWAhbig4qKMvtxP1iRQjsDPcq3AXmOQ1qQx2kRlXjmhnDFucEUMyTAyLj4tL9u5acLk0sfeDdCqidZ/0btPqNqqU6zcfKrDplLqHEiIGEMke1VKqX2yu+31x8xiLB76w7W0p73IrfzJK6Yl3JGEMFRat6kNu0qPcNDq41Ki8YEKBmZMd0dA6/Q4SXNJYAOHwHbkajss3+E/0OXn/ggEJt3yf9h+aPbftHIF89N7+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GQ+wK9A2cB7lwZOLCeofhhy0WCyOssWj8lMJWIbDDE=;
 b=M9ADYCoiis1NFNwUcnaIdp2553Wdc9xok4sW6DpvS6L0cvMYE3gHR5VV9Z1X1mOJKbHTWFM4vaI62Hn3h1cqZUT9WbaNkM4nTboAfk/lXJ6B1RAGVvLyi5Vu4WhZVWtNXpA7RJWqMmmTLKHlIUvaX+UXbPAgtHVpFOg690NjiTs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7852.jpnprd01.prod.outlook.com (2603:1096:604:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:21:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 19:21:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYzcqKYY4b2kXLe0WOhVN2yiYRM6305vMAgAAYvSCAAC8MAIAAFDGw
Date:   Wed, 28 Sep 2022 19:21:11 +0000
Message-ID: <OS0PR01MB59224752DBF6A49D98682F1986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com> <YzRRJD/VTbgesoEI@orome>
 <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWaNULmoUvgeboDrxT92w=iCPY0ucDuU19O1E0buqXgbQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWaNULmoUvgeboDrxT92w=iCPY0ucDuU19O1E0buqXgbQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB7852:EE_
x-ms-office365-filtering-correlation-id: 7f796d62-1713-43f5-061e-08daa1869aa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdihT3lgP34U5ngmQDZ3W22Rv2f/XNR4j7FWIm+xT0mo5olWw+9taCZhunc73zqyu9z3FtNQDvEyA0b3qSy/2P2uscB68Bv3Ju2oCr+aSgQbraWA0Lt5AemsJju/quGXsDnUZPsY41P2c6aGMNUQINZEIx2oxJ2UYgCAGtYzJwhqIhOLB64QMePtNfvPlTVfN8sF9q5psHHYpYjlg6FZgfvJaZLn9tO14+Z12ejjErzp9/oH4yCZr5gM35USMPPp7JLQSrVC3Bu+58NEY13vesXNdvPLi0/MN7jkg7bpJ/9dJ7CdC0+lGuqm/xPsyqmX4vZBsHAxRiif4kDeicVr0XvUtKr0JqYQYVy8f3j0WEsIwFTwSANLgeanuT+0QDLDuApQyn9mGLbT5jxX44RVcfbfA2QzSTaOcgX3Xk2TMwu48EG3+6WMlVEHlrqz9SOEQcfVs4Q1/nGhXGuJmnBxGqD/xPs5fS0UQyFHsc+C4VBH3Lo7sHOaaUItleSijJ1cyf/MpBWYTxW8Imc+c9XGaZZisiIry/sA9udXHaqOq1ywfwkuqRFM4LFQQqUZzslLeVueiNQfD4grWUQs5215jxTFrNuxqihqzgmLT0BYUobFgFtzTO2Y3EciNyIGZSSpeinYfLN1OxXWJlekpmc3H8IX+OxrtyWW/6p6u9n7kcB8TL72I7l5PlUS+NWbnn2VBThZlpYKpd4njwp29p/d18ugAvHzuCHDBVzy0vTh3/kOOh/NSEDetEwt3qfPrROx/2lwA7Gk7Tk49nppBfjIBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(83380400001)(5660300002)(186003)(8936002)(26005)(53546011)(71200400001)(54906003)(86362001)(38070700005)(55016003)(6506007)(7696005)(52536014)(38100700002)(4326008)(8676002)(64756008)(66476007)(478600001)(66556008)(66446008)(316002)(66946007)(9686003)(76116006)(41300700001)(6916009)(122000001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c09ybmZNMHpkakdqU1BOc013M3J4Ni9sNkkxK3pOR1hYUEVTVGhOdVBXSXVk?=
 =?utf-8?B?eVU1ZVYxMkw2NG5SY1FZbmR5SEFqOXc0UStBOTR0OVVOQy9WR1VHSXJoanBj?=
 =?utf-8?B?NTRMeWZXckxxU0JQZ2pVdkl6VEFrUktocC9lMnhXQUxGQ1JIWjNtajgxZkJG?=
 =?utf-8?B?VThEa0JYYis1QzAzdWdzRmRycHk3ZHQ1MjFxMEdqRHRGWmdMcTZpOEVPUllp?=
 =?utf-8?B?ejNwR2Z6aGtGQ0p6V0V4NlFNQUNYSS9tbDRaTU9IcEtFNXAzQ0NzYmxSOGhC?=
 =?utf-8?B?NjFjR2JQWjRMSFpiWFhBT3VzWHZiVTRobzdGcmlMc3VkQWhtemNUM3lYeHZn?=
 =?utf-8?B?dnA4QlQrTzQvN2RHRWZwOU0xZFNPVEtHZS96dEhjeFZTa0VsQ2ZrRmd1RDhU?=
 =?utf-8?B?WkhGbzVxd28xc2tyTS9uUTh5QXkxNjUxZU0xOHNxbEZYbVZsd3NDM3REdVBo?=
 =?utf-8?B?T3BSdHozQlpWSDY2YWF0UGZJN3dRNlByY0hFbytxR243M1p2MmF6K09tbTYy?=
 =?utf-8?B?a2dDam01WVZVQWhUS2N4elZ5NXhRNmRZYUFmdXk3Ukdid05QUW5MRWt0VXdu?=
 =?utf-8?B?SFF3QmdXUjdTdnUwVkxYWDJCaklac1h4STBtL1FLcVV0RFlzRllzV2J0VXlr?=
 =?utf-8?B?TDdFRzBkOVRDWVgybXhRKzlFRDJzVU5WODJ1UHpwQTJaUHp0K0pZbEdyWGtK?=
 =?utf-8?B?eUtkaDJBM2habmhuUklYL2hQZTBGdzlOcUc1dW5qcE1BK0d5RkJUMlBKQllI?=
 =?utf-8?B?UEgzdHJBUGVkUGdDV2ozK3pKeDVvakx4Yk5TN1BwclE2ODhETytucWRvUmUy?=
 =?utf-8?B?U2FTc0RpMnFCNjFpVm8xS2RLK0ZreTZ4eWJQZy8zMFMzbHBVVDVLZCtwdWdS?=
 =?utf-8?B?aTl5dmY1b0JML2dCVCsrdUJlMGk3ZFQzUHNROEJHVlpIZ3p1T3BJbThmQWVS?=
 =?utf-8?B?eHZOY0hUR0daRFcvVmx6L2F6T0ZORmRiZ0dQK3hUYWNwNzNyMnN2eXVBOTNI?=
 =?utf-8?B?Q2t3eERicU9Wb0x1SURDTXZUMkk2RDlYQ21pNnFDYVIrb2FuYUExb3ZHRXh6?=
 =?utf-8?B?VmJQakMrR0w3TGt3RS9EOWlzdWhzVitTUUFwdXdlVU5qMG9FTllrSm1OaUlk?=
 =?utf-8?B?V0tWQ000cnB2UkNQY3BRQ2N2eG1tRTh4N0Z6NFdCZkFRTkFlT2IwQnJFbHhj?=
 =?utf-8?B?Q09Sb3BNZm54cEQvNW9ublBXcEM0TmpmZk1KWVhqVmpiSFpUV3AzRG55aHEw?=
 =?utf-8?B?NTdGVnlpS29UdUY5QWFOZ3BVdXd0K0gxU056bUI3RkJlZG15MXlpb1plYUFk?=
 =?utf-8?B?NG14dFJtVHlka1ljQmx5VWpuSDdpS3B6U3RKR25LMzFBV3VkUGpwK0RhRkp3?=
 =?utf-8?B?MU5BSjNIUS9rRmVUWEJqdklpYm5QVlp6QlUyVXlQYWliQVczSEU1eXQxcTZL?=
 =?utf-8?B?VVJLREtsemZCMCtNdjFNdkg3MFVuZVluVFRYSzNIaWM4ZWE3djRYTXB3dkR2?=
 =?utf-8?B?c1lrYVpnUS9hblB4M0ZDT2FCbXpXbHdKdW1nY2Z0QytTVjF0bHhaL3BJbXBx?=
 =?utf-8?B?NFRXdjNtNW40dXN2bDlrRHNydURUS2pUUWFUaEd1UmxoR2pkWVMwMDEwaW4y?=
 =?utf-8?B?NXk4NFpnSlR6YjlOeEljZEErTlg1TGhnS3YzRVZHdW1Fc3U4VnpPdXE2UXo0?=
 =?utf-8?B?Nk0yQm1LQS9TNmVOclJxVU5KOGtPWWxlZ3MvYmIrSUlDbmFzMDBGM1p0SHNO?=
 =?utf-8?B?V2VqUlVQMVdhYVJwNEJFdFZLQ0hNaVpkYTNpZ2hoOXlWa3lDRENnRTN2Umdx?=
 =?utf-8?B?M0RnR0JBa3ZTZG1TaGRWSFRHa0NtWTlBejE0R21jWEFncis4aVp1YkJsejUz?=
 =?utf-8?B?QlB6YUY0TmJnUW8wd3dVNU5ya1h3VjFDdWNaMzNtWVY0MFUvaEx3aC9jNDdZ?=
 =?utf-8?B?OHA5WHhOSHJPSDdvUFpyM0hVNCsvK0wwYnRZVGxTWTh5RTc2VW1Wc3MxcC80?=
 =?utf-8?B?YldzVExuUWRCcnBQbXhrUzRrMUV4TUJ5Nngrd0d0QWJ2Nk9hUk85Y1lHTndR?=
 =?utf-8?B?OHA3cWhVeXZYVEx2ek44RHgyMG5VTmRHeEtXK3V1bHlzSmJta0NoUUl6S3FI?=
 =?utf-8?Q?pbM2Oy9sYLE56maKKU6LOqay+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f796d62-1713-43f5-061e-08daa1869aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 19:21:11.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UX99I2qlDY/5PZWbfzxSZFsLx0m96uED420tazY/7o0yh0aNyJs+m7o264IRE8YEUdGL3HbwDoww+breHXDv2qUT8HXl7EDNIct7uV2FR84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7852
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzJdIHB3bTogQWRkIHN1cHBv
cnQgZm9yIFJaL0cyTCBHUFQNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIFNlcCAyOCwg
MjAyMiBhdCA3OjM0IFBNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4g
d3JvdGU6DQo+ID4gPiBPbiBXZWQsIFNlcCAyMSwgMjAyMiBhdCAwMzo1Nzo0MVBNICswMTAwLCBC
aWp1IERhcyB3cm90ZToNCj4gPiA+ID4gUlovRzJMIEdlbmVyYWwgUFdNIFRpbWVyIChHUFQpIGNv
bXBvc2VkIG9mIDggY2hhbm5lbHMgd2l0aCAzMi0NCj4gYml0DQo+ID4gPiA+IHRpbWVyIChHUFQz
MkUpLiBJdCBzdXBwb3J0cyB0aGUgZm9sbG93aW5nIGZ1bmN0aW9ucw0KPiA+ID4gPiAgKiAzMiBi
aXRzIMOXIDggY2hhbm5lbHMNCj4gPiA+ID4gICogVXAtY291bnRpbmcgb3IgZG93bi1jb3VudGlu
ZyAoc2F3IHdhdmVzKSBvciB1cC9kb3duLWNvdW50aW5nDQo+ID4gPiA+ICAgICh0cmlhbmdsZSB3
YXZlcykgZm9yIGVhY2ggY291bnRlci4NCj4gPiA+ID4gICogQ2xvY2sgc291cmNlcyBpbmRlcGVu
ZGVudGx5IHNlbGVjdGFibGUgZm9yIGVhY2ggY2hhbm5lbA0KPiA+ID4gPiAgKiBUd28gSS9PIHBp
bnMgcGVyIGNoYW5uZWwNCj4gPiA+ID4gICogVHdvIG91dHB1dCBjb21wYXJlL2lucHV0IGNhcHR1
cmUgcmVnaXN0ZXJzIHBlciBjaGFubmVsDQo+ID4gPiA+ICAqIEZvciB0aGUgdHdvIG91dHB1dCBj
b21wYXJlL2lucHV0IGNhcHR1cmUgcmVnaXN0ZXJzIG9mIGVhY2gNCj4gPiA+IGNoYW5uZWwsDQo+
ID4gPiA+ICAgIGZvdXIgcmVnaXN0ZXJzIGFyZSBwcm92aWRlZCBhcyBidWZmZXIgcmVnaXN0ZXJz
IGFuZCBhcmUNCj4gY2FwYWJsZQ0KPiA+ID4gb2YNCj4gPiA+ID4gICAgb3BlcmF0aW5nIGFzIGNv
bXBhcmlzb24gcmVnaXN0ZXJzIHdoZW4gYnVmZmVyaW5nIGlzIG5vdCBpbg0KPiB1c2UuDQo+ID4g
PiA+ICAqIEluIG91dHB1dCBjb21wYXJlIG9wZXJhdGlvbiwgYnVmZmVyIHN3aXRjaGluZyBjYW4g
YmUgYXQNCj4gY3Jlc3RzIG9yDQo+ID4gPiA+ICAgIHRyb3VnaHMsIGVuYWJsaW5nIHRoZSBnZW5l
cmF0aW9uIG9mIGxhdGVyYWxseSBhc3ltbWV0cmljIFBXTQ0KPiA+ID4gd2F2ZWZvcm1zLg0KPiA+
ID4gPiAgKiBSZWdpc3RlcnMgZm9yIHNldHRpbmcgdXAgZnJhbWUgY3ljbGVzIGluIGVhY2ggY2hh
bm5lbCAod2l0aA0KPiA+ID4gY2FwYWJpbGl0eQ0KPiA+ID4gPiAgICBmb3IgZ2VuZXJhdGluZyBp
bnRlcnJ1cHRzIGF0IG92ZXJmbG93IG9yIHVuZGVyZmxvdykNCj4gPiA+ID4gICogR2VuZXJhdGlv
biBvZiBkZWFkIHRpbWVzIGluIFBXTSBvcGVyYXRpb24NCj4gPiA+ID4gICogU3luY2hyb25vdXMg
c3RhcnRpbmcsIHN0b3BwaW5nIGFuZCBjbGVhcmluZyBjb3VudGVycyBmb3INCj4gPiA+IGFyYml0
cmFyeQ0KPiA+ID4gPiAgICBjaGFubmVscw0KPiA+ID4gPiAgKiBTdGFydGluZywgc3RvcHBpbmcs
IGNsZWFyaW5nIGFuZCB1cC9kb3duIGNvdW50ZXJzIGluIHJlc3BvbnNlDQo+ID4gPiA+IHRvDQo+
ID4gPiBpbnB1dA0KPiA+ID4gPiAgICBsZXZlbCBjb21wYXJpc29uDQo+ID4gPiA+ICAqIFN0YXJ0
aW5nLCBjbGVhcmluZywgc3RvcHBpbmcgYW5kIHVwL2Rvd24gY291bnRlcnMgaW4gcmVzcG9uc2UN
Cj4gPiA+ID4gdG8NCj4gPiA+IGENCj4gPiA+ID4gICAgbWF4aW11bSBvZiBmb3VyIGV4dGVybmFs
IHRyaWdnZXJzDQo+ID4gPiA+ICAqIE91dHB1dCBwaW4gZGlzYWJsZSBmdW5jdGlvbiBieSBkZWFk
IHRpbWUgZXJyb3IgYW5kIGRldGVjdGVkDQo+ID4gPiA+ICAgIHNob3J0LWNpcmN1aXRzIGJldHdl
ZW4gb3V0cHV0IHBpbnMNCj4gPiA+ID4gICogQS9EIGNvbnZlcnRlciBzdGFydCB0cmlnZ2VycyBj
YW4gYmUgZ2VuZXJhdGVkIChHUFQzMkUwIHRvDQo+ID4gPiBHUFQzMkUzKQ0KPiA+ID4gPiAgKiBF
bmFibGVzIHRoZSBub2lzZSBmaWx0ZXIgZm9yIGlucHV0IGNhcHR1cmUgYW5kIGV4dGVybmFsDQo+
IHRyaWdnZXINCj4gPiA+ID4gICAgb3BlcmF0aW9uDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0
Y2ggYWRkcyBiYXNpYyBwd20gc3VwcG9ydCBmb3IgUlovRzJMIEdQVCBkcml2ZXIgYnkNCj4gPiA+
ID4gY3JlYXRpbmcgc2VwYXJhdGUgbG9naWNhbCBjaGFubmVscyBmb3IgZWFjaCBJT3MuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gDQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvZHJpdmVy
cy9wd20vcHdtLXJ6ZzJsLWdwdC5jDQo+ID4gPiA+ICsgICBpZiAocnpnMmxfZ3B0X3JlYWQocnpn
MmxfZ3B0LCBSWkcyTF9HVENSKSAmIFJaRzJMX0dUQ1JfQ1NUKQ0KPiA+ID4gPiArICAgICAgICAg
ICByemcybF9ncHQtPnB3bV9lbmFibGVkX2J5X2Jvb3Rsb2FkZXIgPSB0cnVlOw0KPiA+ID4gPiAr
ICAgZWxzZQ0KPiA+ID4gPiArICAgICAgICAgICBkZXZtX2Nsa19wdXQoJnBkZXYtPmRldiwgcnpn
MmxfZ3B0LT5jbGspOw0KPiA+ID4NCj4gPiA+IFNvIGluIGVpdGhlciBjYXNlIEkgd291bGQgZXhw
ZWN0IHlvdSB0byB3YW50IHRvIGhvbGQgb24gdG8gdGhlDQo+IGNsb2NrDQo+ID4gPiBwb2ludGVy
IGhlcmUgYW5kIHVzZSB0aGF0IGluIHRoZSBydW50aW1lIFBNIGNhbGxiYWNrcy4NCj4gPg0KPiA+
IEJ1dCB0aGUgYXBpIHVzZWQgaGVyZSBpcyAiZGV2bV9jbGtfZ2V0X2VuYWJsZWQiLg0KPiA+IFRo
aXMgd2lsbCBlbmFibGUgdGhlIGNsb2NrcyBhbmQgaG9sZHMgdGhlIHJlZmVyZW5jZSAoZm9yIHB3
bSBlbmFibGVkDQo+ID4gYnkgYm9vdGxvYWRlciBjYXNlKSBhcyBpdCBhdm9pZHMgdHVybmluZyAi
b2ZmIg0KPiA+IHRoZSBjbG9jayBkdXJpbmcgbGF0ZXIgcGFydCBvZiB0aGUgYm9vdCBwcm9jZXNz
IChpdCBwcmV2ZW50cyBjbG9jaw0KPiBvZmYNCj4gPiBieSBjbGtfZGlzYWJsZV91bnVzZWQoKSkN
Cj4gDQo+IFRoZSBjbG9jayB3aWxsIHN0aWxsIGJlIHN0b3BwZWQgaWYgdGhlIGRyaXZlciBpcyB1
bmxvYWRlZCwgb3IgaWYgdGhlDQo+IGRldmljZSBpcyB1bmJvdW5kIG1hbnVhbGx5LCByaWdodD8g
T3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KWWVzLCBpdCBpcyB0dXJuZWQgb2ZmIGR1cmlu
ZyB1bmxvYWRpbmcuDQoNCnJvb3RAc21hcmMtcnpnMmw6fiMgZGV2bWVtMiAweDExMDEwNTQwDQov
ZGV2L21lbSBvcGVuZWQuDQpNZW1vcnkgbWFwcGVkIGF0IGFkZHJlc3MgMHhmZmZmODFkOTMwMDAu
DQpSZWFkIGF0IGFkZHJlc3MgIDB4MTEwMTA1NDAgKDB4ZmZmZjgxZDkzNTQwKTogMHgwMDAwMDAw
MQ0Kcm9vdEBzbWFyYy1yemcybDp+IyBsc21vZA0KTW9kdWxlICAgICAgICAgICAgICAgICAgU2l6
ZSAgVXNlZCBieQ0KcnpnMmxfbXR1M19jbnQgICAgICAgICAxNjM4NCAgMA0KY291bnRlciAgICAg
ICAgICAgICAgICAyODY3MiAgMSByemcybF9tdHUzX2NudA0KY3JjdDEwZGlmX2NlICAgICAgICAg
ICAyMDQ4MCAgMQ0Kc25kX3NvY19zaW1wbGVfY2FyZCAgICAyMDQ4MCAgMA0Kc25kX3NvY19zaW1w
bGVfY2FyZF91dGlscyAgICAyNDU3NiAgMSBzbmRfc29jX3NpbXBsZV9jYXJkDQpwYW5mcm9zdCAg
ICAgICAgICAgICAgIDY5NjMyICAwDQpkcm1fc2htZW1faGVscGVyICAgICAgIDI4NjcyICAxIHBh
bmZyb3N0DQpyZW5lc2FzX3VzYmhzICAgICAgICAgIDY1NTM2ICAwDQpncHVfc2NoZWQgICAgICAg
ICAgICAgIDQwOTYwICAxIHBhbmZyb3N0DQpkcm0gICAgICAgICAgICAgICAgICAgNTYxMTUyICA0
IGdwdV9zY2hlZCxkcm1fc2htZW1faGVscGVyLHBhbmZyb3N0DQpyY2FyX2NhbmZkICAgICAgICAg
ICAgIDM2ODY0ICAwDQpyZW5lc2FzX3JwY19pZiAgICAgICAgIDIwNDgwICAwDQpzbmRfc29jX3dt
ODk3OCAgICAgICAgIDQ1MDU2ICAxDQpzbmRfc29jX3J6X3NzaSAgICAgICAgIDI0NTc2ICAxDQpy
emcybF9hZGMgICAgICAgICAgICAgIDI0NTc2ICAwDQpjYW5fZGV2ICAgICAgICAgICAgICAgIDQw
OTYwICAxIHJjYXJfY2FuZmQNCnJ6ZzJsX3BvZWcgICAgICAgICAgICAgMjA0ODAgIDANCnJ6ZzJs
X210dTMgICAgICAgICAgICAgMTYzODQgIDEgcnpnMmxfbXR1M19jbnQNCnB3bV9yemcybF9ncHQg
ICAgICAgICAgMTYzODQgIDEgcnpnMmxfcG9lZw0KaXB2NiAgICAgICAgICAgICAgICAgIDQ1ODc1
MiAgMTgNCnJvb3RAc21hcmMtcnpnMmw6fiMgcm1tb2QgcnpnMmxfcG9lZw0Kcm9vdEBzbWFyYy1y
emcybDp+IyBybW1vZCBwd21fcnpnMmxfZ3B0DQpyb290QHNtYXJjLXJ6ZzJsOn4jIGRldm1lbTIg
MHgxMTAxMDU0MA0KL2Rldi9tZW0gb3BlbmVkLg0KTWVtb3J5IG1hcHBlZCBhdCBhZGRyZXNzIDB4
ZmZmZmE2ZTZkMDAwLg0KUmVhZCBhdCBhZGRyZXNzICAweDExMDEwNTQwICgweGZmZmZhNmU2ZDU0
MCk6IDB4MDAwMDAwMDANCg0KQ2hlZXJzLA0KQmlqdQ0K
