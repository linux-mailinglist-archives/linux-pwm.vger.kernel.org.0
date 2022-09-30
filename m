Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063E5F055B
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiI3GvW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 02:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiI3GvQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 02:51:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75810EDA1;
        Thu, 29 Sep 2022 23:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYmOmBziSYSxMfnjayq9MAv4wuscaiAM/hULMYBSMuy2Utt1uy7SgD8AykjZVrI2yntI5x5lzpA92PviFPKz7kecYRfYB1bfA3P6IUn10+f3jPyH1kUDSWb/aHybQOHhc7YbUJ63BHCl2wSE2IuDnBMOwrP0boAI+zNcHEcdWJdvv9bVYtyV2EPN4J0Nv3AVe9VmAHZCZaPmIg1EjixAnZIpFrw/9oN88GjcOCf+JYXGRMt+o+RVkfhYneSvNFXUnvkXkM04kvLtkffPGxufZvISR8SxgZhw6GYAV+BUpicwsbt4vljt7AxxXwMp6SBLrFI0pUB/b7hbVJl94hXj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu/OKoFQJhUdz4dK0DScDvuHxtuIChABNAqYJsNv3DE=;
 b=WLiZfVhDi4aHXNKeHiO8FuqjpBhzH+LtU186WEDmQQrdqQ+S10iq8IgIMpVsiMXki2L64FndKGsqZF1lhyZG5rbWQAv9OnBJvHZdHBayzXadGf3lULO1LHMWys+oBN5E4J6OXESeLSu445lDmzzN79l/Jz2ipmwAWpc4rgCe3uuXFE/Hb0e07j7qAhBworoZsW+tUvgkRI369kzLOMhMRUET4oIc7TWrvekeL3MpUKf4AtuNJmWm0PFaxXlC7bcidrhAUEB9heEHlJHxkrd+k8DUUNk2mKYNIwCHZyyNNUruuyNR8zrfxgLSDrWidvCs2z/5ssVDojyXm5vTJ48dYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu/OKoFQJhUdz4dK0DScDvuHxtuIChABNAqYJsNv3DE=;
 b=thn+/smTYfbEeenwAD5lRd7Fspgf5djRFVwIrQ7Yi35iyAEwXgShCvDGJtxyX1g66TEM64tL2uL03CvoExVjbmtmwU7scQwNoDoeyT4v7g+JOwfjsSiyZFjjrOXiZfF2I6DTOrkZnGq1DRYr63VOPfsTSzg+k8vM01WjsYNlvSk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5540.jpnprd01.prod.outlook.com (2603:1096:604:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:51:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:51:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYzcqKYY4b2kXLe0WOhVN2yiYRM632twhggADaxYCAAAMdQA==
Date:   Fri, 30 Sep 2022 06:51:12 +0000
Message-ID: <OS0PR01MB592278A1194D0E8B36123F0E86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220930063429.xlcmimr6m3z3o5wh@pengutronix.de>
In-Reply-To: <20220930063429.xlcmimr6m3z3o5wh@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5540:EE_
x-ms-office365-filtering-correlation-id: 4d51362c-0702-41a7-3ddf-08daa2b0297f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ci3LDLoAuTLU0ToLhUhwlqQZVgit6PijHcu9FmJOdB6djYjUFUBfuWM11CjfYUjLZ07vFFjGbKnTaTj9uoZloDJE1fh33aYAktsDwK232cIxzdkN6dd7aI7dJquwA1BtYArfQZQ/oBIqtSj5cwCiiIXon+zuaC2gRmP7dd4WxVHXlEW+4+AnVF+YqZa7W5YB7Vba4V4EB3CeF3KQ45wyT2eUwtGb36EwCvvmbGa+d9G3zNJR8hRLxOFgUOYD3x7AxoD+qMni6EkBLqzeWrLyiB+DiHQ6ZXd9NFtW3xluIPI20Do32OnFmghBmxPY+Qqi+6nEjRa/n7B82gYajF5+V6EgVA2+4ZUxumkKbjtMhRMae4juXKji74p3vd4r2rAR1AtM1NaTl+QRwV0WnveeDZLeIb9q46LQw9Y6fxT8C5Wp7VxC8HYM28NGt9ceKxlPZuSpbrPkgLkd1hX8qUUiAT148MvAe7+b/vdgyq3q9rcs+P64dByQMGy8Q9L3j9zv4p7vJVQiclGbnpYwcLcRxXk/qKv7Bc6luESfLWuiVeEaPTo7MDbD/4XKZ4/2z2c9cvZIFQG0xp4ko5hob+wK1YfvRZNV0nyTNgRgVlJguNZn9ORiAN0W0NDHyGE5mw0wECVyiFbKZr90G0ewrZEWTpdGXn/KyQH25wejqI4L8DZi5U/phTPR5cg69ugRiuF2Vxtw1q/Rpg9xScxkllkqUMSQL9zB059NW8di1tP6G1qJwnZpolG2nWSWfUh+6CzmsMhrpRrY2cKfkZKFWq6RaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(38100700002)(122000001)(71200400001)(6916009)(55016003)(86362001)(54906003)(478600001)(2906002)(33656002)(186003)(7696005)(9686003)(26005)(5660300002)(316002)(6506007)(8936002)(66446008)(66556008)(66946007)(52536014)(64756008)(38070700005)(41300700001)(8676002)(66476007)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVYxT3ZYVElaemFhWWdwK0FtSnFtdGZRbnBHSGpsLzNWWURMSlY2S280MHhE?=
 =?utf-8?B?ZTRCRTk2SlFDaitFWi9TUnk2Q3VmcGpIU2l4QnFuWXMvQXI5VjcraVJOYWZ4?=
 =?utf-8?B?QTNhbWtpUGErbjdpVXE3REVlUGZuOWNTZ1BackE2MzMyM0NHc1lNOEkwSUVr?=
 =?utf-8?B?K2dmZTBCTFh1NXFQVE9pY2FWQ0g5N2EzNlNBUTh6N0t2NnZYcjRzVEV3RklN?=
 =?utf-8?B?VktxUy9vN3llZVNzNzR6czFvWnRwc2JkNHVpQ3hRemRlTUp0T3NGNnhyeW4w?=
 =?utf-8?B?eTAvMTg0STFLSWR6bTlUVUhTZ3ZMNFFFckNyTitnUnFMSDhCM01PVVVSMHhJ?=
 =?utf-8?B?cUtFZFVQMU01d1VoaUJUSzlXVjNCYUJBQXNyaUpKakJ2bDZsRklpWjVPdE5U?=
 =?utf-8?B?M3FrWjhWWFlQZHNUMXdZK04wNFl2UDFLVGRMSHNPTDB0Sm80QXBIRW5Gck1O?=
 =?utf-8?B?Z2M2YkJTRWkvNVRPVU5XZmNuYmEzSDA0ejVmRE5NQkluQnUvUkVCdkhNMzVn?=
 =?utf-8?B?YXp5OXF5UVBOa2p5cVhZVFlnU0ZUYW9nM3FhVFNsNjE1cTRYTUxadzYrdDNY?=
 =?utf-8?B?MDhPRmtKNWRhQmtMY2tjbnowcWZvdE0xNkQyNHo1S2hYYXV2RTFKVlRVd0NK?=
 =?utf-8?B?dWNWZE02RWpLSXJqQ0g3V3BnL1RpRVNNTUdjdkY3dW0rY3FBT3Y4LzIrNzFX?=
 =?utf-8?B?WGZmWld3UEZDeUNxai9SRzdXZldLSjlGRmFSWi9XTC8vRzV4WWVyUkhjZk9Y?=
 =?utf-8?B?WXRNekVFR2pXR0hSdWVkMlhsZmV0RWl5OEFTYktmYlFTSWo2dXU5MndKZTFp?=
 =?utf-8?B?MEhreTExQXpKMzFpVlVNbnkrT3QzZHNicFloVUZ1ZTEvTlBpMkFDakVLTXRX?=
 =?utf-8?B?OUlPbDlqVVNQWkY5cit1b1dnOFBka2FZSkZlWnN2SFllSjhoTGtCNDUzKzJn?=
 =?utf-8?B?S296VHFaN3UwZlQxLzVtM280NWFVQ3Z4aVROamQwbHFWcUNsS0FMWnhmeFRM?=
 =?utf-8?B?cE9BbTNXd3A1cFpiV1ROLzJxOGZpSElvS3ppSVMxN0d6dHltODBEakNWZ0pm?=
 =?utf-8?B?NmpFZlF3alN1SVY2ZitqRDk5TmpPZDcvOW5OaFREbVZqVzllU2NIdHE4RkM2?=
 =?utf-8?B?VFI4a1NScFU2NHRPZy9FUmYvcVBvREROSWlEUFNEV0Z6T0RGRVNjaVlJSVkw?=
 =?utf-8?B?RXpxdDJxNlcvSUpsVFBianFrRzdoUnBCY2dqbVBZN1RaQlhFRWhPNWQ0SWt3?=
 =?utf-8?B?ekVHVWkxRi82UXJSNmF0eEVtK0Z0cDVQa1RKZ3RTZVBOOW5sSFNBdmxwajEy?=
 =?utf-8?B?ZWttRzBwZHUwWU1XTTU3emtCYnhKTkFMZFZSL2h3K3dQNzVvcEk5L0lTYUJk?=
 =?utf-8?B?UnQvY3g4emxON2c1L2lRZU9aRit2dzd4RUJnSDFyNWt0VzZBaEdvYmppNkFu?=
 =?utf-8?B?Rllpdmw0V3VjVWpHR2dybVJBNVp0NmZqM2RsZzQ1ZFFSUzdBUFFVa1R6RmZi?=
 =?utf-8?B?RFlndFRBWGJJdk8yaW1tU3czb29pNmRDWk0xREpOUklBZDhVMWJ5ZlQ2VW83?=
 =?utf-8?B?bnNOMUVHSjRDL0V4Wm5XbUFFdjBNS3YzVEFpVjI2WGNmRDlUenJqUklxS0ln?=
 =?utf-8?B?RWZkYlkrcGFuNVNsRU5IZ1ljVmxtSVZEV01PcXJSeE5yQkNQLzMvRXdsZUNO?=
 =?utf-8?B?ZnRWeCtpMlQzVUFiaFhCeTZmWHFwS1NzNGEzUHdXRlBtUHdqUUZZQndoNlQ2?=
 =?utf-8?B?UTN0YUg4WU5takRqZkpmQmpxT3JHY0FvbzVlTlozYVpENlBxNWpLNE9uYThN?=
 =?utf-8?B?VzNGVkd0WFVqbTBZcWJHTWdrSUNLeVRtZ0RZNUZnd2FPTExYM1ZZZzFHazNa?=
 =?utf-8?B?YjdoMzByd0oyNGw4MlJPVmNlQ1JsM25UYzlLUVlWMW1xblp5RDkwOTBZeDFJ?=
 =?utf-8?B?UEtOaXllaEN5Tks5WDA5UmRnTGNXUldld3A5TGNlbnJrYTR6aG1oZEhpTmZk?=
 =?utf-8?B?NzlSYzZWc3JWREhMUEpJd21RbHhDeEw0VlE0bG9UQmY2TEwvN1hTMW10c1la?=
 =?utf-8?B?QWhLSlpOMElJS0NSd0F6N3JhbGFwajJKRWtKUWRGVmpyZU5mbnNreUVHVnZz?=
 =?utf-8?B?REkyZnpnUlR2NnJwemF2Z2g3c0hWWEZhQVBMbEx1MkZTMTBqcnpkbWt5dWpx?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d51362c-0702-41a7-3ddf-08daa2b0297f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 06:51:12.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaVruNwWTBBGjPhal85dAka5+D3gL3/Vt8XXY//BwzHK+wJcyupkv7h7/UiHxBP/2CylruFrXBMDy9M5nZWOn278DKxqVzkJUGgd5uo6Zcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5540
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBwd206IEFkZCBzdXBwb3J0
IGZvciBSWi9HMkwgR1BUDQo+IA0KPiBIZWxsbyBCaWp1LA0KPiANCj4gT24gVGh1LCBTZXAgMjks
IDIwMjIgYXQgMDU6MzY6MzhQTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiArc3RhdGlj
IHU4IHJ6ZzJsX2NhbGN1bGF0ZV9wcmVzY2FsZShzdHJ1Y3QgcnpnMmxfZ3B0X2NoaXANCj4gKnJ6
ZzJsX2dwdCwNCj4gPiA+ICsJCQkJICAgdTY0IHBlcmlvZF9jeWNsZXMpDQo+ID4gPiArew0KPiA+
ID4gKwl1MzIgcHJlc2NhbGVkX3BlcmlvZF9jeWNsZXM7DQo+ID4gPiArCXU4IHByZXNjYWxlOw0K
PiA+ID4gKw0KPiA+ID4gKwlwcmVzY2FsZWRfcGVyaW9kX2N5Y2xlcyA9IHBlcmlvZF9jeWNsZXMg
Pj4gMzI7DQo+ID4gPiArDQo+ID4gPiArCWlmIChwcmVzY2FsZWRfcGVyaW9kX2N5Y2xlcyA+PSAy
NTYpDQo+ID4gPiArCQlwcmVzY2FsZSA9IDU7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJCXByZXNj
YWxlID0gKHJvdW5kdXBfcG93X29mX3R3byhwcmVzY2FsZWRfcGVyaW9kX2N5Y2xlcyArIDEpDQo+
ID4gPiArIDEpIC8gMjsNCj4gPg0KPiA+DQo+ID4gVGhpcyBhbGdvcml0aG0gd29uJ3QgZ2l2ZSBk
ZXNpcmVkIHJlc3VsdC4NCj4gPg0KPiA+IHByZXNjYWxlZF9wZXJpb2RfY3ljbGVzCQlFeHBlY3Rl
ZCByZXN1bHQNCj4gPiAwCQkJCQktPjANCj4gPiAxLi4zCQkJCQktPjENCj4gPiA0Li4xNQkJCQkJ
LT4yDQo+ID4gMTYuLjYzCQkJCS0+Mw0KPiA+IDY0Li4yNTUJCQkJLT40DQo+ID4gMjU2ID4JCQkJ
CS0+NQ0KPiANCj4gT2gsIGluZGVlZCwgaXQgZmFpbHMgZm9yIHByZXNjYWxlZF9wZXJpb2RfY3lj
bGVzIOKIiCB7IDAsIDMsIDE1LCA2MywgMjU1DQo+IH0uDQo+IA0KPiBUaGUgY29ycmVjdCBmb3Jt
dWxhIGlzOg0KPiANCj4gCWlmIChwcmVzY2FsZWRfcGVyaW9kX2N5Y2xlcyA+PSAyNTYpDQo+IAkJ
cHJlc2NhbGUgPSA1Ow0KPiAJZWxzZQ0KPiAJCXByZXNjYWxlID0gKHJvdW5kdXBfcG93X29mX3R3
byhwcmVzY2FsZWRfcGVyaW9kX2N5Y2xlcykgKw0KPiAxKSAvIDI7DQo+IA0KDQpSb3VuZF9wb3df
b2ZfdHdvKG4pIC0tPiBuPTAgaXMgbm90IGFjY2VwdGFibGUgDQoNClJvdW5kX3Bvd19vZl90d28o
NTgpLS0+IDY0ICBhcyBwZXIgdGhlIGFib3ZlIGZvcm11bGEsIGl0IGJlY29tZXMgNjQgKyAxIC8y
ID0gMzINCldoaWNoIGlzIHZlcnkgaGlnaCB2YWx1ZS4NCg0KSSBhbSBzdXJlIHNpbmNlIHRoZSBl
eHBlY3RlZCByZXN1bHQgaXMgbG9nNCwgd2UgZG9uJ3QgZ2V0IHRoZSBkZXNpcmVkIHJlc3VsdCB3
aXRoDQpUaGUgYWJvdmUgZXF1YXRpb24uIFBsZWFzZSBjb3JyZWN0IG1lLCBpZiBJIGFtIHdyb25n
LiAgDQoNCiAgICAgICAgMA0KICAgICAgMTAwDQogICAgMTAwMDANCiAgMTAwMDAwMA0KMTAwMDAw
MDAwDQoNCkNoZWVycywNCkJpanUNCg==
