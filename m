Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA064B792
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 15:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiLMOjo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 09:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiLMOjn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 09:39:43 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8BC11E;
        Tue, 13 Dec 2022 06:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUI6PKFrMPmLl0uPLin/irdu6DCvXvcL39nVKPOP65zIEulcowinAbbnGKT2KPdT1BCRqMWJZiebEt06SQZPK4L/uNo+dtHpSQcLhkvhcH+c10F2OvQox/PMnw5/NpIx6jzBNwtZzJ+2QiK0SnXdLxCcMikkHYQXa/w9oZZsLwfGL/hF0tinaeih3gzFX+wBKJC/rKsOxIZAzTd6qDyv/NVWKM0UbwWJeH07Ah08Ead9Igw8hVSzJ62S7hsX9lLoG2DpfOF91n+XW/gW4AHU0jjijvj8DwmZA6e4onUYaTGVlKZ6RLjDOcSRJNbJWG/ZjC4twkMjXHP7s69TCmr9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCcQZ/jtr/dHA8t3t1zDfYsbHJPFwiSpmk5zuhsHgNA=;
 b=ShLPuRz4u+/C0BmAyv0X1XiJ2hIq0u8pBSxTdCIRFkEt2/KGHtOOXdCIkeacSB62FBguwdO1azM2lXLbGPn/88g80gYG7iKfsdj3B+T+KDlukr55ZLfqgR6e5pv43mQPvooA+NdV/h6Wrahnnun3v8Lk89YYDXwk/xcZGSEIs5JnDnjP6J7S48oomD6HD3ixGT4hlt2UGCIJVqUWm9P5SnvGDW7E00mhJn/zm5akrGTTIedS8Y7ecyWckvO2FxHoBvKPHNk5EdhuyCEw882qAKe0zht3NidH1qmdfnNfa+PD13DaC1syyvAedFInzY0ac1/oKnvermBKhngd40xPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCcQZ/jtr/dHA8t3t1zDfYsbHJPFwiSpmk5zuhsHgNA=;
 b=nnJ7t9OIDjejPbXf4lzHL70FmLzojjr7PvPJACyRQbNt70M6fn9hXDr2ipgV0gGf6Mwu/ei5H8XohrWcmeSzM/h48uYSughfMaAjyZ1CudYz/UBQtMHivVn/5+aXCpanl3IKVk1zUQohaT6HkW4B5R7lg+nDFNdS3qCvh51J4Vs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9827.jpnprd01.prod.outlook.com (2603:1096:400:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:39:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:39:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
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
Subject: RE: [PATCH v11 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v11 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHY9en2a3dn+IZDS0WrKuqWEllk6a5sEUeAgAAEKqA=
Date:   Tue, 13 Dec 2022 14:39:39 +0000
Message-ID: <OS0PR01MB5922CE4D6A4FFC39A809DA7786E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111162325.471963-1-biju.das.jz@bp.renesas.com>
 <20221111162325.471963-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdUzT7=xT1nJ9o7eSgzUGu5vb1c=gWg=CgJ9Ay1tmJgpDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUzT7=xT1nJ9o7eSgzUGu5vb1c=gWg=CgJ9Ay1tmJgpDQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9827:EE_
x-ms-office365-filtering-correlation-id: c5e60689-4ac0-4b79-13e3-08dadd17dd47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzW5smN4ytXJZfPbrD5HL5UDyT+WvAS32ZS13mB51dUFwch8uuhx9QzJ4tHG0yKXqJJDIzF260HxBri7Y2c/6NQbSu5A6YKrPFg2DDtqoV427rIsXEWOO8Doq0PdbId8JSyAvQegHpfKCf6vRAWdqrf0/Ve/RE2lLUCrRRxXoRgUPZgOjeq6k4ChwwieyjeVaVXui7gpVRuOoQZI2b7d4Xj0XR4iX1WKRPPoXPh2nr46PDpziDZfVIZb7PdaR7pvQZmUkf1vHK4P1BroOk8rrQAaYs52NzPN2cxRXHUvGuI6d7TU5dvEeW05csh5mE1ERru5oKU+eT0beVpOTDE7VuXn28OCEtJEmDsbUmYUHyolno5VcUvQCZ2vdteYS2J+NJyjZMqdVXfVKVTerH7Z2zp+DDHFQV102sVClUSKL6tMnhVA5kDw1If1Conj/Veq56fkrNg+axK5PIUZdcpTTAn3xe6isMlqK6VPZa/hxXd7ti3oWfA5NqsId5p31GSRn+Q1IOfaMICmhvFj4Xl19RBX/4l/iD48WTDWQKpimBCu/Jg3PrSNWvAHJgWi/bZUo9+Aut7uQd2i+dYHmu8Ut6fri+lHYUGFlHodvdpnEoJwGIIjG00GoystwJBkbiQ6ObIGGQc8RYBFg1V7KzJkdUw+e/3YsdpOYa9W3OsxX2HusQ0oloJcWdkGHk5UrOA9LZyCrzycFRYDc0yDrB/GTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(71200400001)(478600001)(38100700002)(41300700001)(122000001)(86362001)(53546011)(66446008)(26005)(6506007)(7696005)(9686003)(186003)(64756008)(76116006)(5660300002)(66476007)(8676002)(66946007)(38070700005)(33656002)(55016003)(2906002)(66556008)(83380400001)(6916009)(54906003)(4326008)(52536014)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHJaYUhCckhUaHVnaDNNeWZoU0hPY0ZCZ0tqYnNYZjRhd1BHaWVuRVQ4b0J6?=
 =?utf-8?B?U2J3M3Q1dUJQR004cFdJUlBhV0hVVVB6MW9jMko5ZEthWjVaeTl1WDk5T3Vu?=
 =?utf-8?B?QTh0ZmJpU0Z5WEhNY0NpaWc1M3ZpNVczaDA3Qjd0NWRDYWp1Y2Z4eE84QVBp?=
 =?utf-8?B?dW9taHdZY0VCTVg2WWU4WXFTZWxhQjlDbkh1ZmFsL0FwUThwSTM4amJrT0dn?=
 =?utf-8?B?MGZacE8wbG1PMiswanhINVdJM2NGTzY4dlBNMmNHckJRd3htMVByTmhjWTVx?=
 =?utf-8?B?SmFMbmcvSWRDV1FyQi9BWlRTOG9peHJBWlJKelpoRURmNXBGc1pVMzBqMFlN?=
 =?utf-8?B?KzlQZ1p5bG9udFJ6Z3ZBdEdydDZIV3JIVmxLZkk2dGdLVGo3NllXZE11TElW?=
 =?utf-8?B?Rkd0S2RVdnRvVEM2ZEpqenowaGJPRjBUQlNLazBVRWo0VUlFRkNjVlhZT0s1?=
 =?utf-8?B?YnMrblptU3F4SlNWWVZnVEJjTGdQMHNPK09CWE05ZGFSTk02WFhDK2Q5QzdX?=
 =?utf-8?B?cU5FZU5CZ2kwMlZIZTNyNmpWU1hPcmxPR0x1cDZDR1g4MDBwUnc0dllsWTNN?=
 =?utf-8?B?R1pMRjMyMTdGWnhjOEx2Y01RdHhiUFdvZUozYVhuYnpoVnVENGZsbTdrUFk4?=
 =?utf-8?B?Qmc2anQ4RExhZWRvenZlRTQzZXBkNFc1dWF0K2J6TzkxWkxJOFVReURFVmRn?=
 =?utf-8?B?aHdTc1JFNUc0bWhOUjJ1dFJ4b2xMV2FIc05aSHd5a0VnYWxYbkU0THNtbkI4?=
 =?utf-8?B?am5jL3R5U3JQakwrSWlqUWxHU0lNc1NXRlYwYXp6MmRBRHEvT0xycUFJS3VD?=
 =?utf-8?B?YnFLQnJIUlIySWFJazc1eG5zRWd2U1NyS3pCbmpsTC81K05URjJBdXRsZk1x?=
 =?utf-8?B?WnRORWN3bmNHMzFuN0dIYUp1TkRiVWh5Z2NDeExFclV5Q1pSVFhueXA2dUdj?=
 =?utf-8?B?S0R4RWRWRkxUZktyV2J6UFc3UFdUMkdydEIxVG5BMWxlQ0hRdTJqT1I4OGdS?=
 =?utf-8?B?eE1NMXVHY252TEU2Y0FBVkxPN2tSYUJLOHpNRkQ0dWRpWUZtaGYyaTh0blRq?=
 =?utf-8?B?UWZ6ZmFnWnFrR1hUY0xJaE5HU1kzcnhZVWNFNXJXS2d0NjF6QlZPUFQzWE03?=
 =?utf-8?B?a2x1TGQ0WmlKQVRlSmU2d043dDZPNnVkVE5SeUh0MC9rTUtQanRTT0gzbkwy?=
 =?utf-8?B?aGN6YXVISjI5Z2lIS3RhemJsUDNicEFmMnFucElHVEFlekx1VEpKTXFvSFBE?=
 =?utf-8?B?N2NPN1BXaGw2dkZxbmZtQmFDZDZ3THZ3YUwyV1BONTdjRU1oSERqVWtua2pF?=
 =?utf-8?B?b3lqb2lzRmtsREN2VTFWZW9vdzRQQWthN0ZGWElPRTFMSEZvb2VWSGRKQ2Y0?=
 =?utf-8?B?MXBBYVA3QjVtY2FjK2hqc2x1RUJlY1ZTTlFmYk9PdC9ZWGp0bXA4dlVpM2ll?=
 =?utf-8?B?QTY5NEx0TGh2MGtJVFhiNzVseFhJVEg4eXVaUHZJRUJSa08zS1hJMkNLQnZo?=
 =?utf-8?B?WEs3cU1qM0p0ejIrbTZNVUREUFkrdWVEUWQwdVN0a2JWVTFDZXZWT1B5MlpY?=
 =?utf-8?B?Rll1ei9DQU9kdmYxZ0R2cThQYWpxYXdXWmJhb0FQYUNpSEFmcEVnZ1JqVTJl?=
 =?utf-8?B?RURnNjRXclVieEpjWGYwNCtWMXQ0ZVRHWXh5YTNYR09XSlN3Y3djTlV6eVhC?=
 =?utf-8?B?STVpNExrWk9zQUJTTzYwR2wyZUZsWWtrbU5yQUxJendidmxQaGJXS0JSQ1di?=
 =?utf-8?B?bzFNK3N1WlBsMjk0c042cGNSWW9lVEk2S0xyMlpEZ3B6UE1uY2w4ZlVhRHY4?=
 =?utf-8?B?MDgvUENxdkIwU0F3ZXZGTGdYNTVlUjUyUXpObUs2WWJGdkJ4cTNpcnkxaCsw?=
 =?utf-8?B?Wk5jS0xpUm1uQWpDVTFyZG5VcFlHdldpaFNhUlV6M3JpcDlRa0pYSTZvcGE3?=
 =?utf-8?B?aHV4Z2lUdFFhaGlNM3RnUnpFNnA5eUVzbFhjNWx6OEhDZFl5QU5kbVlxQmhL?=
 =?utf-8?B?TkpsUnhhbzdacVNqV0xPZjBiZlh3OU9FNTVzNjFWNlN0RHppTUliZHJpdEsz?=
 =?utf-8?B?aVpFWUdaS2tjSmFCLzBPekRQTGdFK05XSlMrbFoweHQxRG0ySnZZR3ZVelAx?=
 =?utf-8?B?VFZ2ZkF1bU1IeVZEUWlyM3JuamZqc3Q4VW5JWkYyaUVZMUVzVUNtUWpEL255?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e60689-4ac0-4b79-13e3-08dadd17dd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:39:39.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXs7corBRsW2LPbzd7hKIr3dwNSKd49382tr0lK2TcH7NIIt+w8Ha1nBmlJ0KQwONWUZ++h/JgvJzGD51M74HvbjveOORnGHXcuPdx1na4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9827
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMi8yXSBwd206IEFkZCBzdXBw
b3J0IGZvciBSWi9HMkwgR1BUDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gRnJpLCBOb3YgMTEs
IDIwMjIgYXQgNToyMyBQTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
IHdyb3RlOg0KPiA+IFJaL0cyTCBHZW5lcmFsIFBXTSBUaW1lciAoR1BUKSBjb21wb3NlZCBvZiA4
IGNoYW5uZWxzIHdpdGggMzItYml0DQo+ID4gdGltZXIgKEdQVDMyRSkuIEl0IHN1cHBvcnRzIHRo
ZSBmb2xsb3dpbmcgZnVuY3Rpb25zDQo+ID4gICogMzIgYml0cyDDlyA4IGNoYW5uZWxzDQo+ID4g
ICogVXAtY291bnRpbmcgb3IgZG93bi1jb3VudGluZyAoc2F3IHdhdmVzKSBvciB1cC9kb3duLWNv
dW50aW5nDQo+ID4gICAgKHRyaWFuZ2xlIHdhdmVzKSBmb3IgZWFjaCBjb3VudGVyLg0KPiA+ICAq
IENsb2NrIHNvdXJjZXMgaW5kZXBlbmRlbnRseSBzZWxlY3RhYmxlIGZvciBlYWNoIGNoYW5uZWwN
Cj4gPiAgKiBUd28gSS9PIHBpbnMgcGVyIGNoYW5uZWwNCj4gPiAgKiBUd28gb3V0cHV0IGNvbXBh
cmUvaW5wdXQgY2FwdHVyZSByZWdpc3RlcnMgcGVyIGNoYW5uZWwNCj4gPiAgKiBGb3IgdGhlIHR3
byBvdXRwdXQgY29tcGFyZS9pbnB1dCBjYXB0dXJlIHJlZ2lzdGVycyBvZiBlYWNoIGNoYW5uZWws
DQo+ID4gICAgZm91ciByZWdpc3RlcnMgYXJlIHByb3ZpZGVkIGFzIGJ1ZmZlciByZWdpc3RlcnMg
YW5kIGFyZSBjYXBhYmxlIG9mDQo+ID4gICAgb3BlcmF0aW5nIGFzIGNvbXBhcmlzb24gcmVnaXN0
ZXJzIHdoZW4gYnVmZmVyaW5nIGlzIG5vdCBpbiB1c2UuDQo+ID4gICogSW4gb3V0cHV0IGNvbXBh
cmUgb3BlcmF0aW9uLCBidWZmZXIgc3dpdGNoaW5nIGNhbiBiZSBhdCBjcmVzdHMgb3INCj4gPiAg
ICB0cm91Z2hzLCBlbmFibGluZyB0aGUgZ2VuZXJhdGlvbiBvZiBsYXRlcmFsbHkgYXN5bW1ldHJp
YyBQV00NCj4gd2F2ZWZvcm1zLg0KPiA+ICAqIFJlZ2lzdGVycyBmb3Igc2V0dGluZyB1cCBmcmFt
ZSBjeWNsZXMgaW4gZWFjaCBjaGFubmVsICh3aXRoDQo+IGNhcGFiaWxpdHkNCj4gPiAgICBmb3Ig
Z2VuZXJhdGluZyBpbnRlcnJ1cHRzIGF0IG92ZXJmbG93IG9yIHVuZGVyZmxvdykNCj4gPiAgKiBH
ZW5lcmF0aW9uIG9mIGRlYWQgdGltZXMgaW4gUFdNIG9wZXJhdGlvbg0KPiA+ICAqIFN5bmNocm9u
b3VzIHN0YXJ0aW5nLCBzdG9wcGluZyBhbmQgY2xlYXJpbmcgY291bnRlcnMgZm9yIGFyYml0cmFy
eQ0KPiA+ICAgIGNoYW5uZWxzDQo+ID4gICogU3RhcnRpbmcsIHN0b3BwaW5nLCBjbGVhcmluZyBh
bmQgdXAvZG93biBjb3VudGVycyBpbiByZXNwb25zZSB0bw0KPiBpbnB1dA0KPiA+ICAgIGxldmVs
IGNvbXBhcmlzb24NCj4gPiAgKiBTdGFydGluZywgY2xlYXJpbmcsIHN0b3BwaW5nIGFuZCB1cC9k
b3duIGNvdW50ZXJzIGluIHJlc3BvbnNlIHRvIGENCj4gPiAgICBtYXhpbXVtIG9mIGZvdXIgZXh0
ZXJuYWwgdHJpZ2dlcnMNCj4gPiAgKiBPdXRwdXQgcGluIGRpc2FibGUgZnVuY3Rpb24gYnkgZGVh
ZCB0aW1lIGVycm9yIGFuZCBkZXRlY3RlZA0KPiA+ICAgIHNob3J0LWNpcmN1aXRzIGJldHdlZW4g
b3V0cHV0IHBpbnMNCj4gPiAgKiBBL0QgY29udmVydGVyIHN0YXJ0IHRyaWdnZXJzIGNhbiBiZSBn
ZW5lcmF0ZWQgKEdQVDMyRTAgdG8gR1BUMzJFMykNCj4gPiAgKiBFbmFibGVzIHRoZSBub2lzZSBm
aWx0ZXIgZm9yIGlucHV0IGNhcHR1cmUgYW5kIGV4dGVybmFsIHRyaWdnZXINCj4gPiAgICBvcGVy
YXRpb24NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBiYXNpYyBwd20gc3VwcG9ydCBmb3IgUlov
RzJMIEdQVCBkcml2ZXIgYnkgY3JlYXRpbmcNCj4gPiBzZXBhcmF0ZSBsb2dpY2FsIGNoYW5uZWxz
IGZvciBlYWNoIElPcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2MTAtPnYxMToNCj4gDQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1yemcybC1ncHQuYw0KPiANCj4g
PiArc3RhdGljIHZvaWQgcnpnMmxfZ3B0X2dldF9zdGF0ZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAs
IHN0cnVjdA0KPiBwd21fZGV2aWNlICpwd20sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgcHdtX3N0YXRlICpzdGF0ZSkgew0KPiANCj4gQXMgb2YgY29tbWl0IDZj
NDUyY2ZmNzlmOGJmMWMgKCJwd206IE1ha2UgLmdldF9zdGF0ZSgpIGNhbGxiYWNrIHJldHVybiBh
bg0KPiBlcnJvciBjb2RlIikgaW4gcHdtL2Zvci1uZXh0LCB0aGlzIG5lZWRzIHRvIHJldHVybiBh
biBlcnJvciBjb2RlIChidXQgeW91DQo+IHByb2JhYmx5IGFscmVhZHkga25vdykuDQoNCk9LLCBX
aWxsIHJldHVybiBlcnJvciBjb2RlLg0KDQpDaGVlcnMsDQpCaWp1DQo=
