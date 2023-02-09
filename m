Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246D3690178
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Feb 2023 08:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBIHoX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Feb 2023 02:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBIHoW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Feb 2023 02:44:22 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E12A15E;
        Wed,  8 Feb 2023 23:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrJs2iBw6t5QDTTSHQxI3whSYn3rfNz54CjvBHyYKniYZ28tynmIlVcpSZ63cDyRx4gHwuCYeavL3Zd18yKJLBqzeirNsMOGEaRZH10Koiv2yHo9tmazgeraBKKkc68SFQn9rKJ1UD2Z4Fjb7XOuNTaIUw/tniK5P6IErVWI5gXoTMnJ03GQKV4iyF8OARI9OeoSWpUrtAwjf1s5XUI7ycKyXbnxwxwcKVMwiSknnAiH9Z+QHK022AF434Noo8kMDCm8bc9tpQ03ebqKV0uZ+cjcZHjiNLt3SCQujhb53FiJUfNWBHXqSoejTKh41OOL6OhvQHUJA++L/HQk4/L6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g8Qt9cpM+4AULUmbHJf6SV4Zl5rDxItnELaU/mBQgw=;
 b=PofNhdzlb9KZvOZzNthuag6SpP9DZx3xwvak2jcTC2P7OWfnE0ovEFABxd6F1NFwsdGAz3wnjTAcV1wA6kYQ/C0LAzzhGghfeY+BII2mCwb99s2wadtZKpr7xP7C7Ow3wqSwki2gYkLpn9QCioU5c6Q8UgdZWUBM2mYFNtKhXeQAOqyWo52rDKEtJDXcf1dEvvp2oRjXDhjAkAVbmiWFPi2W90dwrZsUdOKt+ybdV1G7kzO7Do+j/GiMPWub4iWvzfdZEwL/vidZ04+aRFbpwVy7JqHMclFl8iVT5v0VeCm6ELfZUsPMWbj6z9wWwocOn5CV3Vf6YEBjnKD5j1FM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g8Qt9cpM+4AULUmbHJf6SV4Zl5rDxItnELaU/mBQgw=;
 b=wJgoYyzOG4kzrtjumaccuprCLMoY6ABKqMotV6gXwMsHv3Jk+QUcPm5wwKwzrigDTNbu/P1rihGWF+yVtTsWnDrlaEejU2sMvQdgHoEio4bzi48ZHC3hZwjNhl4UxTF0NeDy/1kn7rNH1Uuu6ERTrb1MRKXU17twVroDB3n9ZBI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6237.jpnprd01.prod.outlook.com (2603:1096:400:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 07:42:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 07:42:42 +0000
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
Thread-Index: AQHZDyTrx1aPUVR9Qk+gIxiBq8WX966nvBuAgBMfisCAC7n84A==
Date:   Thu, 9 Feb 2023 07:42:41 +0000
Message-ID: <OS0PR01MB59224002D8C9C48F35B8E20186D99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
 <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
 <20230120163525.rhtgexzmizotnvrg@pengutronix.de>
 <OS0PR01MB5922E6F023F223AC4DB944AF86D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922E6F023F223AC4DB944AF86D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6237:EE_
x-ms-office365-filtering-correlation-id: ff6f0d43-dbd6-4602-81c4-08db0a7139c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: riat/VAb1onbNxSdwRcs54CLum3CVH9gnF5KrrsooeoURAYRJfTQfQuV2wcfWrGLCHLvo/ilvrHTutuTw863ATkEQe5IsX0HRA23wdzyVfe4ojk+oBPpRDuSgvYcOoZSSj2rx76xdBm4Vp3vXWuBflsrTlUrwDH8UH2JB+nrceCMyMUtD7c1AMSinz34aTLKFWh2++NJIwS9KDAhTBjuXGEJ4To489F86bsnCcrGM7Jc7222pUwoKZ8lfqY6X+Tzgpi64eiGTddbpEGJQZ3m80eUL8dyzcd739gn8NGz/Si7spUh6VywdAjLtAhH0IVFPytieNdqziAbpMRONpxQVyuj1e4ln+ZWA+is4hPVjGNhzb6QDtSuNY0IrDD1HwkdpFOrlzZ6vkFu+7GUXnVGy9Pbi/++U/mMmMirSXkxJrBT8R9POdk+gJbAu0+HJ8gXHMWi0HajvVK7MIysjQq9su6tPm4XUUegQ7q+ripZAjk82xVBSE2c3h8M1h7q+FgkaKHtXyGQPaLJYjvlsjec5RDQ05nqDbs2AT/pnuc6UTZbYowZRantQ+O7EcpULmXv3974xJxwc7pOOXWhyio/VHysNgQUecoRMceS8gGpEsHgvrrczSaK77CZEnTsIrX1VvS739uUvkaTMhOPL+ySMIMrSC9qDKYfn5yARdf2kgbzbAznabluJTHOle03j7/lM0xKQ6RDfsRI9sg4mwwmGf4iMFuaehFdhvjqBWIviac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(122000001)(38100700002)(86362001)(2906002)(33656002)(38070700005)(54906003)(316002)(41300700001)(5660300002)(52536014)(8936002)(83380400001)(66556008)(76116006)(4326008)(8676002)(6916009)(66946007)(55016003)(64756008)(66446008)(66476007)(6506007)(966005)(478600001)(26005)(186003)(9686003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhoYlFRUVZzWmd4NkthK0kxUyt2U216T3Jtc2hkOFlBOURjU0Z0a0NIYWh5?=
 =?utf-8?B?K0lGbE43eHFCZm1OY093YzFEZklJaVo2MW1KTkpUZFVGc2pHbVhsY3E0TWFx?=
 =?utf-8?B?aVlST29CV1dkaTZwSXQvTTZRR0xrbEFKM0R5SFQ2QWxacVlsMDVWUVBveTJX?=
 =?utf-8?B?bGJ4ZnRQUlIwcjZreTRtakRxZi8yQXF5dWVQQVZ5ZEtlNmI0QXN6WitsOEdv?=
 =?utf-8?B?Mjk0V1JPL1g3RHZyMzdJbkxsVTV0T2k5N1dQM0FKdXpKeHJTTEhTc3ZHK2lZ?=
 =?utf-8?B?VzZubXNDWnE2ckczcTdURGd3VmdGMkc2TGN6VHlCRkk2bjhraWVJcGNhQkow?=
 =?utf-8?B?OXpWT2xLOEJxaDh6Q2RsVTdKbDJoL2JDYkVaRGE2RHRZVHpNK2xsRjZZTXll?=
 =?utf-8?B?ejFwaWxEd1RUR3dsaTByTHNzeEswdUdteWwxYnVhUEhDMnNHSmlIL2FISmJY?=
 =?utf-8?B?NnNVMUpnOStYMEdNVVR4SHpuL002WUt6Ui9EZFZVMUYzaURhZUtjY1BiQ3RJ?=
 =?utf-8?B?WmQxSUxEakZtSXN1elczL0JVQS9BVXpuN0FhOE9Nd00wVnpqdTJUc0E2a0pN?=
 =?utf-8?B?TzI4WDV1NWJXVloyQU1DM3dmUE12RlhkS2dzcEMwWGNIQlMxa3A0SmRycHFx?=
 =?utf-8?B?UFh5VlJMam9sM0kwejZxTWxGa3ZHamxwaFlHcElnL25lUUFGT3I5bEs3VTlr?=
 =?utf-8?B?Y0FMS1NuRUVoRFpSNWNCNEdZSEljQ0hSd3dZRXVRelc1bHhOOXdaU3ZuUE5i?=
 =?utf-8?B?L0h2U09RS1lVcllscWNzMTBLZm81MjB2Z1hSRGRxdklWaFVZazRVYlVtNnkv?=
 =?utf-8?B?YXRBWGVSMGdtVmx3MGFjSyt0cXFEU242V2xBT3AxZXNZUWMrVlZQV2NCcStv?=
 =?utf-8?B?dEFYcExublhxOTBUMENUdE1FNlRNbUR3bTZFSDZRdUFndlZmMlZvTTlYM2F2?=
 =?utf-8?B?dElRZC9pYXZpVHBYbVh2ZkEvV3ZXdHdkU0NNbFhwQXNWWDVUdUV0WGZpblgy?=
 =?utf-8?B?dkJSMlRyNnRrOUtIellleG44TzhwajU5LzZXNmgyTjlJMEg4YUd3YmViOERG?=
 =?utf-8?B?emwvWExCNWJnMml4ek40c0I4Z3Zpc25LalBaQ2IxbGFWemdVL2JSNUh5S2xs?=
 =?utf-8?B?OE85WHFHdUk3cGZ0TzFNTFVGR21TK0dmaGU2K0ZXNHRLM1pKbGJmbjcyWmE4?=
 =?utf-8?B?ZzRmTUUrNVZWQUVSK3FPMHlhTkhFS0phMCtoTm9sckNCT1o1L1M0VkdteWVm?=
 =?utf-8?B?UVV6OXdJN2VlbnJFbm1mOXpqK0dzWldROGNDRlgwQVYyL2M4R0tHTWJjWDdH?=
 =?utf-8?B?bnZ6cU5kSGJQMHgzc1BBM2NCdnNSclVuRFo1S1l5UUhnZVhkSUtQMHFHN0lq?=
 =?utf-8?B?TndtV21LVTdGd3Z2YXhOQkdkSTR1OFROS1JySlBTRitKc3FOck05YVkvSkt5?=
 =?utf-8?B?NVdidFZWNnRYZTNkZ2dFb2o2S3RTR0o4T0tEY1R3blRmNG9ENlpsNHlkdnc5?=
 =?utf-8?B?alhmbVY4UTcya0cyakJRWUZiT3JLZUlVdmxYd2hjU3JWbkwwVlZTSysxV0kv?=
 =?utf-8?B?MGFDYVA2Z0R3R1dFa0w5ZFFXcXU5VmZSTTdZbG0yNHpZVElHcGZXdmI0bm0z?=
 =?utf-8?B?THFCSDl6ZnVlejVNWmFVV0x5dEtJK08yMGF1V1pXcU1obXFCSko2VDd6eWdk?=
 =?utf-8?B?Z09Mckk3VVBMQXZsMVpudldRUm5mN2ZvVXl4SUdSM1NBVVJ0NzhodUx0dGJp?=
 =?utf-8?B?blByZmdnMk8vdVlOQ3YxRWV3c21YTUl2eGRReGhpeGZiUWR3blUrTjlEaUdK?=
 =?utf-8?B?WG5HY2dhenU5VVhxQWV2OXNHRFZybEM1T210RFllZU5kdGRkcDhoanJSL08x?=
 =?utf-8?B?Q0NaWE9RYi9EK2cwTFpPUFNKZGc2RktzZEhyYjVPZ09HdFVhSWhIeTdIZ2Q3?=
 =?utf-8?B?QXA0eEorQldORFF3eFZhUHpqK3FEWWtmWUhVVVo4bld6bjZjeElGclpoOTBO?=
 =?utf-8?B?YUIrNk92eWNnQVhnM212dFJ6RmR5emtMeitTSW92UElzSXdWMXlHemtraEdP?=
 =?utf-8?B?eW5DeW5IdHRxeVpOc05Vc1h1T3FiUG12a1RzdHhXT2FKMUZ5Uy9uYUk5eW83?=
 =?utf-8?B?R2E0M3p4Um5PaVp6QUVmYzZsR0VobkdnYlpDRlFxL04zNGhjMG9IYTBhZExl?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6f0d43-dbd6-4602-81c4-08db0a7139c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 07:42:41.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtFMCA4x3p7BKPCjtEE0vKpFUVfK3WPFJlRtfRUG9U55NjCCOuzTxusTkK2SO8h5J5GkH38dCbPTFtz04eGbMLefWDfGI7iBSN1Y912HpKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6237
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQpJIHdpbGwgc2VuZCBuZXh0IHZlcnNpb24gaW5jb3Jwb3JhdGluZyB0aGUgcmV2
aWV3IGNvbW1lbnRzL2Rpc2N1c3Npb24gYmFzZWQgb24gdGhpcyBwYXRjaCBzZXJpZXMuDQoNCkNo
ZWVycywNCkJpanUNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDIvNF0gcHdtOiBBZGQgc3Vw
cG9ydCBmb3IgUlovVjJNIFBXTSBkcml2ZXINCj4gDQo+IEhpIFV3ZSwNCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrLg0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNF0gcHdt
OiBBZGQgc3VwcG9ydCBmb3IgUlovVjJNIFBXTSBkcml2ZXINCj4gPg0KPiA+IEhlbGxvLA0KPiA+
DQo+ID4gPiArICoNCj4gPiA+ICsgaHR0cHM6Ly93d3cucmVuZXNhcy5jb20vaW4vZW4vZG9jdW1l
bnQvbWFoL3J6djJtLXVzZXJzLW1hbnVhbC1oYXJkDQo+ID4gPiArIHdhDQo+ID4gPiArIHJlP2xh
bmd1YWdlPWVuDQo+ID4NCj4gPiBJIHRvb2sgYSBsb29rIGludG8gdGhhdCBub3csIGFuZCB0aGVy
ZSBhcmUgYSBmZXcgdGhpbmdzIEkgbm90aWNlZC4NCj4gPg0KPiA+IFRoZSBQV01DWUMgcmVnaXN0
ZXIgZGVzY3JpcHRpb24gaGFzOg0KPiA+DQo+ID4gCVRvIGNoYW5nZSB0aGUgc2V0dGluZyB2YWx1
ZSBvZiB0aGUgUFdNIGN5Y2xlIHNldHRpbmcgcmVnaXN0ZXINCj4gPiAJKFBXTW1fUFdNQ1lDKSwg
c2V0IHRoZSBQV01FIGJpdCBvZiB0aGUgUFdNIGNvbnRyb2wgcmVnaXN0ZXINCj4gPiAJKFBXTW1f
UFdNQ1RSKSB0byAwYiBhbmQgc3RvcCB0aGUgY291bnRlciBvcGVyYXRpb24uIElmIGl0IGlzDQo+
ID4gCWNoYW5nZWQgZHVyaW5nIGNvdW50ZXIgb3BlcmF0aW9uLCBQV00gb3V0cHV0IG1heSBub3Qg
YmUNCj4gPiAJcGVyZm9ybWVkIGNvcnJlY3RseS4NCj4gDQo+IE9LLCBJIHdpbGwgZml4IGl0IGlu
IHRoZSBkcml2ZXIuDQo+IA0KPiA+DQo+ID4gVGhpcyBpc24ndCByZXBlY3RlZCBpbiB0aGUgZHJp
dmVyLiBQbGVhc2UgZWl0aGVyIGZpeCB0aGF0IG9yIGFkZCBhDQo+ID4gY29tbWVudCB3aHkgeW91
IHRoaW5rIHRoaXMgaXMgbm90IG5lY2Vzc2FyeS4gSWYgeW91IGNob29zZSB0byBhZGhlcmUNCj4g
PiB0byB0aGF0LCBhbHNvIG5vdGUgaXQgaW4gdGhlIExpbWl0YXRpb25zIHNlY3Rpb24gdGhhdCBJ
IGFza2VkIHlvdSB0byBhZGQuDQo+ID4NCj4gPiBJbiAuYXBwbHkoKSB5b3Ugc3VidHJhY3QgMSBm
cm9tIHRoZSBjYWxjdWxhdGVkIHZhbHVlIG9mIFBXTUNZQy4gV2hlbg0KPiA+IGxvb2tpbmcgdGhy
b3VnaCBzZWN0aW9uIDE3LjQgRnVuY3Rpb24gRGV0YWlscyBJIGRvbid0IHNlZSB0aGlzDQo+ID4g
anVzdGlmaWVkLiBIb3dldmVyIGluDQo+ID4gMTcuMy4yLjIgdGhlIGZvcm11bGEgaXMgYXMgeW91
IHF1b3RlZCBpbiB0aGUgZHJpdmVyIChpLmUuIFBXTW1fUFdNQ1lDDQo+ID4gPSAoUFdNIHBlcmlv
ZCAobnMpIC8gKFBXTV9DTEsgcGVyaW9kIChucykgw5cgRGl2aXNpb24gcmF0aW8pKSDiiJIgMSku
IENhbg0KPiA+IHlvdSBtYXliZSB0ZXN0IHdoaWNoIG9mIHRoZSB0d28gaXMgY29ycmVjdCwgbWF5
YmUgYWRhcHQgdGhlIGRyaXZlcg0KPiA+IGNvZGUgYW5kIG5vdGUgaW4gYSBjb21tZW50IGFib3V0
IHRoZSBkaWZmZXJlbmNlPw0KPiANCj4gSSBnb3QgY29uZmlybWF0aW9uIGZyb20gSFcgdGVhbSB0
aGF0IGJlbG93IGZvcm11bGEgaXMgY29ycmVjdC4NCj4gDQo+IFBXTW1fUFdNQ1lDID0gKFBXTSBw
ZXJpb2QgKG5zKSAvIChQV01fQ0xLIHBlcmlvZCAobnMpIMOXIERpdmlzaW9uIHJhdGlvKSkg4oiS
DQo+IDEpDQo+IA0KPiANCj4gPg0KPiA+IEFsc28gY29tbWVudCB3b3VsZCBiZSBuaWNlIGFib3V0
IHRoZSBmYWN0IHRoYXQgdGhlIG5hdGl2ZSBwb2xhcml0eSBvZg0KPiA+IHRoZSBoYXJkd2FyZSBp
cyBpbnZlcnRlZCAoaS5lLiBpdCBzdGFydHMgd2l0aCB0aGUgbG93IHBhcnQpLiBJIGRpZG4ndA0K
PiA+IHJlY2hlY2ssIG1heWJlIHRoZSBpbnZlcnNpb24gYml0IGhhbmRsaW5nIG11c3QgYmUgc3dp
dGNoZWQ/DQo+ID4NCj4gPiBBIDEwMCUgZHV0eSBjeWNsZSBpcyBvbmx5IHBvc3NpYmxlIChhY2Nv
cmRpbmcgdG8gRmlndXJlIDE3LjQtMikgd2l0aA0KPiA+IFBXTUxPVw0KPiA+ID4gUFdNQ1lDLiBB
c3N1bWluZyB0aGlzIGlzIGNvcnJlY3QsIHRoZXJlIGlzIHRoZSBwcm9ibGVtIHRoYXQgdGhlIHR3
bw0KPiA+IHJlZ2lzdGVycyBoYXZlIHRoZSBzYW1lIHdpZHRoLCBzbyBpZiBQV01DWUMgaXMgMHhm
ZmZmZmYgYSAxMDAlIGR1dHkNCj4gPiBpc24ndCBwb3NzaWJsZS4gU28gcGxlYXNlIHN0aWNrIHRv
IG9ubHkgdXNpbmcgdmFsdWVzIDwgMHhmZmZmZmYgZm9yDQo+IFBXTUNZQy4NCj4gDQo+IFdpbGwg
YWRkIGJlbG93IGNvZGUgdG8gdGFrZSBjYXJlIHRoaXMuDQo+IA0KPiAJLyoNCj4gCSAqIEEgMTAw
JSBkdXR5IGN5Y2xlIGlzIG9ubHkgcG9zc2libGUgd2l0aCBQV01MT1cgPiBQV01DWUMuIGlmIFBX
TUNZQw0KPiBpcyAweGZmZmZmZg0KPiAJICogYSAxMDAlIGR1dHkgY3ljbGUgaXMgbm90IHBvc3Np
YmxlLg0KPiAJICovDQo+IAlpZiAocHdtX2N5YyA9PSBwd21fbG93ICYmIChwd21fY3ljID09IEZJ
RUxEX01BWChSWlYyTV9QV01DWUNfUEVSSU9EKSkpDQo+IAkJcHdtX2N5YyAtPSAxOw0K
