Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C605FBC55
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJKUn5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJKUnz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:43:55 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCB72B51;
        Tue, 11 Oct 2022 13:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTndKk31KGpxLmge4OLB0zCB8DW5nxWO7DXitljk0T2G1ZiazEZ8eLTtcM6EKCXMpIgKB7/5L4wQMP8BfdH/T5xT/1whFtpLndQKQ+CMAk0LBBxi7UOqrDKLYfW6jKart+zvvRr6gECvUqsBdERWR9GpQRYjNU2yZaus6Gzp4IlTNINniXXD7Dbg67XImgi30yj/mm9kCvAfaGHbInDVCXBzbdX3fGxIdkTw965qS6EvH3M8NoXl/eyB2bTj89bBcdZaionErhfTUI4eskpXRjdil73B56h4ITKXGHuOEgFlr8/lPJG6n+iY67wzY+N7zE2sz39Ye3ocWbgBsncAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmpa1sY55lE7u9e9PzJJQA6JAgKn5m9tZoXBQhyLQ5w=;
 b=L+/3PqN+SHvTS4eeJ/H9Y1oYka1a/KQ3Qws4IMZSh2G+ZtlZpMnqSBKNkHjd6vWVC5cZLbWHprLh4ER/XNUnfm/jw9KE8EwUiajLcfx3IO5F6paYzrn0dsT8hRNZ+M8R5flb5h6l8NGAZJKzMdo8ZsgkYfYS3jLF0fzXjYEzJWuNgxf3VDSxLxrsAmeTTNto2O7GQu+4hhzGQfV9/hJj2BFTfTeJuMK6b1So8o4REoSr6w0YoDZJ27OdeoGc+hrZS07f5cpGaBePhH5RnO4DrkjP8S+l4NoQcllOUdYnZOmgK5rxYmUow8S5BthBaSA5waCRk1pEET0HZLZ1WX1PFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmpa1sY55lE7u9e9PzJJQA6JAgKn5m9tZoXBQhyLQ5w=;
 b=VolzSMXFq2LcGYTVpbFCYGnWT4yCfa/iiDa7nq8VybpFk5SR2BFqf12NrpH2R77jb5knhzA6cBy6MYaZ3a/xL6efVpeS3VWp4tEzM51nSxf3m2EExT73IebG5a7tmQupDz8bOjZN80q8Ir6VljiRl5M+4iyJV3ZA1Eqk2tlBmrI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10485.jpnprd01.prod.outlook.com (2603:1096:400:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40; Tue, 11 Oct
 2022 20:43:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:43:51 +0000
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
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64JjDKAgAACnKCAABKoAIAAATcwgAADlICAAAF6AIAAAXgAgAAA2nA=
Date:   Tue, 11 Oct 2022 20:43:51 +0000
Message-ID: <OS0PR01MB5922130811695F9B906EA62E86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
 <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
 <OS0PR01MB5922E406D2711AA6B8CD632C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ddfb11e0-0704-1600-d89c-ec8ca1650c38@linaro.org>
In-Reply-To: <ddfb11e0-0704-1600-d89c-ec8ca1650c38@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10485:EE_
x-ms-office365-filtering-correlation-id: 86d828a5-16f8-4061-7807-08daabc94dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RE934PwfDhhhwfaJtY/bXci99V6UXKNLbNS4duKJ3tUvBIzAQ8CZnjvE+92beLYf4HqltN41iAcA5/swUTRd+ckuzDq9VU7ImJrbr44N7CK83A0P63okJKiUC40MYa+JU5JYoXsRpXWofbflY05nVpHhJclZyDnDWWV953+FzfVcuZ4IVopDyRiuZq8uySFLpcL+PTUjLsFqjk/vhDO7wzMcJa9soUVuC8vyyq0DF96/f59nddAabzmp1lEmpCR88sopuXsjsBaKjem/ayIu51vcllOGl+x+rzEOVfyNAhDDT7BedMYIemlu3GZ/0ByPFrTjdx49dVtznEWSfBgQ8UpKodyTXMBC3kAaCMyNeQs7Ciz1UnRRaHfAzN8CLwj0I8b3j+Mje8RTidxp7spdjzfheL+S+A7fHimplgb+s6xYEZyEakbcvU8elJ7xC/a5M1z9qjVKO9Ms/lv81472Vif36AhQqDPLlx+Gt2wPBBTSyo5eHu5A10i9YP3L5enMqpjdSy2nsaGG8EZUIQOrRjhk/asCn5LbC2ITTiH/qIJd3yKv2nICIfEM+K9HxsKeIO8FHHbEoXotvVip++2beQWBqFz2/6wUwH/bu+rpg1IUc85REVKsOznT0kCecYn/3/LM0h7Ox0pDPfmLjpskNbdNpvwpg9/9C8i14ib6S4Db+zuXN3eEfbw8VnKZGY1JTmxT84LNUrDwVJmOD9e1Pe10gDzuUzHliTBdAaI/TE09dTNOUHljkDLI7O37YSnDag3QSWXaYWGRZOpN7Z4aLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(52536014)(66946007)(8936002)(41300700001)(64756008)(478600001)(66446008)(66476007)(71200400001)(8676002)(4326008)(76116006)(110136005)(66556008)(316002)(122000001)(54906003)(33656002)(6506007)(55016003)(38100700002)(38070700005)(7696005)(26005)(9686003)(86362001)(5660300002)(53546011)(83380400001)(186003)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXI5NDVHZEMxQWVPUGttNnRwVGRDamhTcWRRdkt3TldBaVArRGNMSXhXQU03?=
 =?utf-8?B?NXJsRzMzNlZ2RXlFMVRpRFBqajdHdjdwRXltVzZqcjgxQ01rWXVmWThvL1hX?=
 =?utf-8?B?cDFYU2c3a2hQVEsyWTVpbFNsY0MzTjNSb21qYkh0dU1mRjVVYUVXVHcxaUsx?=
 =?utf-8?B?NzZ3T2pHNDc1dnQrQWFwVHVQdXJNeTJVR2tMSjlEWE9BUUJYWmlvZC9GK2lq?=
 =?utf-8?B?YThDSkpuRE40c2xzb3pHNis4RXdPeFRlOW9tNS9lWFFvQzVsbHArK0ozT0tF?=
 =?utf-8?B?YUw2Ync3dUk3aDBjb29uVm9FZW92ZGpTZCtWTnZaTm5RVmExK203NFhEV2pS?=
 =?utf-8?B?a3hZb2xxTlNGVVNvWDFWUGdKL2hJWTVNbTRaeVcrR2NTTHZvOG5VanA2L2xp?=
 =?utf-8?B?Y2I3UDNFOVVvakZxYkJIT0tueTk1WTBtZmNnLzFpb0Z6ak15eW1HeTFqUkM3?=
 =?utf-8?B?eHpnNTdLYVNXZ1BiYTRZaStRSFA1ZkpObG1aYi95Z3RQZHFPK1NxcjhCekQr?=
 =?utf-8?B?emxtcHFrUHFNYXhnVXVxb3B4RzV1Z1d3ck1KY29RRU9PYlQyVUJ6QlE1dy9H?=
 =?utf-8?B?Q1JKNm1OdDU2N1RSYXgzUFBvaVZHczkwNVppekNSNEhDR1ZGSHRzWWtSZE1G?=
 =?utf-8?B?TDhXb3FtYXk2QVFDTWxybS9jUU5hYjhVbDE1eENrZ1p0cUNtb1dIY21IdGhu?=
 =?utf-8?B?TXVtMFVpaTdJaGdsZFZaOXNZYmt6TC8vVGhKVitHY3hsMnl0b2lCcG14SlEx?=
 =?utf-8?B?TFFEVU5rNGZqWEI2bHVKR1phQ2p0enJEcXRwMldvajUza2gzRmdNcWR2T0pY?=
 =?utf-8?B?Z0ltL1VjeDVRckFCZjNzVzVvcThqdmQ3VHliWmNMNzhlajhVOTR0d0pPSFl1?=
 =?utf-8?B?QUJDQmE4TUtEY29zNHErUTlxN0ZVSDdDeHpoZWVjUndvQkNSb1FkOGR5aUww?=
 =?utf-8?B?c2U2cHFWcmgwbFRpcFdPSzYwclByYkt4bStXY25TM0R2Zmw4ZmRseWd2S2hv?=
 =?utf-8?B?RllUTFlocFQxckhSR2QwbldmeTBPM3VoTVF3aEphYkdRWXBmSVhmMDA4b0hZ?=
 =?utf-8?B?RnAwc0ZkRGRIWjUyc2UreDlSN1I2VTM3R1lnNzlidmhiZDhTZXQwVlUxbnNo?=
 =?utf-8?B?dk53a05ta3JNYlgwdFdwcDh4cHRPb0Y2VVBuTGQ1bnVEYUJQOXZ0VkRBNEhK?=
 =?utf-8?B?a0JJbHFPT1FobnNTRXFwRnI4QnN2R1N2UHRBS1E4ekdETDhkQkptZ0tCMGZw?=
 =?utf-8?B?cWFYK0E0Y0REWkF3VUpFNkI3T1hjR0Nva3ZpQVNQTDdzWm1Bb244VlNMZDMx?=
 =?utf-8?B?L2o4akFXeWtRbWZMd3dwNmNCcHBTS3BtbS9zWW5qbGZJQWdMdnpGVndjTDdZ?=
 =?utf-8?B?YVRmZ1pWQ3JOMWxWaDlROGZ4OHdPWitlZTh0RzVVUkJkZzF1VnA0L3VOdEdk?=
 =?utf-8?B?Umo5d1V3S1VtLzR1Z2g2VDJra3hjN2pLRk5kUk9MWENkdXlWM3VWVndVaUEz?=
 =?utf-8?B?QWxGSkozOUpWUXRodEhwOVdaZnRWV0R0TFhJT0dnV0E4MjBjNk9UM2FaUEQr?=
 =?utf-8?B?RzRxaXFDUElrTmJJS2huY2ErOHI4L0tVOGxPZWNKZjJoUWM3b0ZaSlFqOHBx?=
 =?utf-8?B?K0JmaXB4ekVZQXRDMHBTLzlmNGtDMVkrQ3kxZVYzenhKZ000WEliTFV1Wjdh?=
 =?utf-8?B?a0VCNUdSS3hKZTZNbUFrc2F5WlNjUG1NTDg3WFFZNmR3eDFPWS9Ybi9SZytU?=
 =?utf-8?B?UHdhKzg4NjlaZmRuaDZTVGxYUXBoaGxuOGd5aDdUQ2VWU0ZFeUVLZlM1dzV6?=
 =?utf-8?B?VUpKaENLLzBQSVpTakUyNlRKM2E4MmVnM0JTMVNVMzJGZUZiQUpCN2NIQjhC?=
 =?utf-8?B?VXd4T2dSR2VSb2RnRTdSTWJPUCtHbk11OUd0QlRIelk0aU94ODdwSGY3Q05U?=
 =?utf-8?B?RnRFYVBXS0V1KzZPd1QrR05NQm5LZWQ1THBYZitmcDhHRXErOU12NDBGQXp6?=
 =?utf-8?B?SjVWWExCaG1BMEJWTElZTzU0aW9STytJcHNVNUlOYUh6U3NlWDFod1N0TUZC?=
 =?utf-8?B?UWJxcC9NbU8weTBPY0VhV2xNaTh1RkpVVkdkODJONEZHTk1oakpHRXNwR0Fy?=
 =?utf-8?B?emlPWU01NGo5YllESnl5aWhTZmZJSEZoMTVEK2pXcnpMSDZPQTl5ekc1OC9L?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d828a5-16f8-4061-7807-08daabc94dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:43:51.0914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nU7TM713LtQqxeBzCFRjnMzxZbJUM+i6uAUcWhDuwFk2MtbzKcwuERul05BEcH3bfr/qz+Wt4Dn7OFOMuS1ICX9cqf78Vsn5/ZRusUutl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10485
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0gbWZkOiBBZGQgUlovRzJMIE1UVTMgUFdNIGRy
aXZlcg0KPiANCj4gT24gMTEvMTAvMjAyMiAxNjozNSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+Pj4N
Cj4gPj4+PiBTbyBubywgaGVyZSBhbmQgaW4gb3RoZXIgZmlsZXMgLSBkb24ndCBwdXQgc3Vic3lz
dGVtIHNwZWNpZmljDQo+IGNvZGUNCj4gPj4+PiBsaWtlIFBXTSBvciB0aW1lciBpbnRvIE1GRC4N
Cj4gPj4+DQo+ID4+PiBXaGVyZSBzaG91bGQgZG8gd2UgcHV0LCBpZiB0aGVyZSBpcyBzaW5nbGUg
ZHJpdmVyIHRvIGJlIGJpbmQNCj4gYWdhaW5zdA0KPiA+Pj4gInJlbmVzYXMscnotbXR1MyIgYW5k
IHJlZ2lzdGVyIGZ1bmN0aW9uYWxpdGllcyBmb3IgcHdtIGFuZA0KPiBjb3VudGVyPz8NCj4gPj4N
Cj4gPj4gQWdhaW4gLSBob3cgYmluZGluZyBpcyByZWxhdGVkIHRvIHRoaXMgcHJvYmxlbT8gSWYg
eW91IGhhdmUNCj4gc2VwYXJhdGUNCj4gPj4gZHJpdmVycywgZS5nLiBjb3VudGVyLCB0aW1lciBh
bmQgUFdNLCBhbGwgZ28gdG8gdGhlaXIgcmVzcGVjdGl2ZQ0KPiA+PiBzdWJzeXN0ZW1zLiBDb3Vu
dGVyIGdvZXMgdG8gY291bnRlciwgdGltZXIgdG8gdGltZXIsIFBXTSB0byBwd20uDQo+ID4NCj4g
PiBIb3cgZG8geW91IGluc3RhbnRpYXRlIHRoZXNlIGRyaXZlcnMgd2l0aCBhIHNpbmdsZSBjb21w
YXRpYmxlDQo+ICJyZW5lc2FzLHJ6LW10dTMiPw0KPiA+IElmIGl0IGlzIHNlcGFyYXRlIGRyaXZl
cnMuDQo+ID4NCj4gDQo+IFdpdGggTUZEIGZyYW1ld29yayBhbmQgbWZkX2NlbGwsIGp1c3QgbGlr
ZSBtYW55LCBtYW55IG90aGVyIGRyaXZlcnMuDQoNClRoZXkgYWxsIGhhdmUgY29tcGF0aWJsZXMg
Zm9yIGNoaWxkIGRldmljZXMsIHJpZ2h0Pz8NCg0KQ2FuIHlvdSBwbGVhc2UgUHJvdmlkZSBhbiBN
RkQgZXhhbXBsZSB3aGljaCBoYXMgYSBzaW5nbGUgY29tcGF0aWJsZSBhbmQgDQpNdWx0aXBsZSBj
aGlsZCBkZXZpY2VzIGluIGRpZmZlcmVudCBzdWJzeXN0ZW1zPz8NCg0KQ2hlZXJzLA0KQmlqdQ0K
DQoNCg==
