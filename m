Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C1D70A4
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgERGAZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 02:00:25 -0400
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:34272
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERGAY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 02:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALih7qk/of/HSqUNyzS+/T+JGBgK2F7P4HN8oaTym/Hg/wLFB21hrOjgHhxDcOaipDZfQMwROyyHC9/mb1rKC8KaLHgaDMH6H+YURboUriQk3FOC3XpMTz0OC1Q+siyNV1JXlNdd7uzvqhQr51mgJT0bBw4OBnQWBvZ0I9SUX7vAV7gwPe9qDW0JqlHfigs/QUO4y/FWu+rtAaNK8cttpRAd4+a2BTd5+MQsSOsR9E75V9dtKzAmBIheZFP33e5YhBxxFIAw6K1g9VpmphLDtpAbd5BJXxwzFBWoLqIsv3YNhFjqgnFvJX22CAeVpZpGpSC0NYeZ62sI3lkUHEEK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w459gZb7u8EecEXO+l/6Jc+2YgIA8MpVGDoMaE1/fTU=;
 b=CJNwEq47SAcq49yLjOKSW9a460VHNEZ78CsIOmI7HpmmSkebGI9QgpOliYnwvj6vyJdTihJRs0oKGZwI6hy3K+9rLuf1n8LTHcLy93093gmgHGQAPp21BamH4pS1OewUxDi24tdJVMWrv4fegzw6exzwDg0pl8e1TRuCZZ13A2MQ8f6dhy0lr4tXBLyUMqURqllI0gzgW7gymdePqGvF2NdjwINS14Yn533oDbbz23/vgRkRYWFVbzL5XHgi52X3+mDHpDa698OVsydxKU+flB2IzJmI8Oy57+/sjSh7h2MEP4uQgK6JgRVrVor3IN1X4rLveUhMhp3xNk9QVxiDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w459gZb7u8EecEXO+l/6Jc+2YgIA8MpVGDoMaE1/fTU=;
 b=Yla8Sx+FbjsKvzRvXq0q1bto3qvExWrHs8lBergISfEtYECUMueJPXpYudVT8xsJsHavj6qoVCkN4NG1TbRg3k4x1GCFztRMVwwMgVgi9yWpntj7X6byd8ST269rVMgg+Ve2L7+yt903BJxyD8UQEyIqstxG1DzJFTj/ppu4UnA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6695.eurprd04.prod.outlook.com (2603:10a6:20b:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 06:00:17 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 06:00:17 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] dt-bindings: pwm: Convert imx tpm pwm to json-schema
Thread-Topic: [PATCH 2/2] dt-bindings: pwm: Convert imx tpm pwm to json-schema
Thread-Index: AQHWKb4QQXKzdjGeTES9B6DZ1n/1y6itX0Xw
Date:   Mon, 18 May 2020 06:00:17 +0000
Message-ID: <AM6PR04MB4966DD209B9A9C244427A75F80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
 <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589439259-28510-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d964508d-4c9d-46eb-791b-08d7faf0bda2
x-ms-traffictypediagnostic: AM6PR04MB6695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66953907F244C4096EF4BB4080B80@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKVH75+RF8J47QN6v+rU0aD8E8TdJdrxxfrK/aDJn1axLPzXjOGcYmMjeZ9iv4kSdB/DrCZXF63WI6UQTnbVnILgwxkP5dApMlPcw3mYs5RQ1vAJVVojebADLZnq51ByxrP6q1hYm8+Hc086RwlvQ24+MgnW0xNe/V7dCZM114MhTh+yPXzORCTJeRRrtactYzFCYlFIF2Vy359ykt9TYYcd5Kklmivv9u8kEJHgEFyo7Yk6ZeRva30/oj2VZb82d8gf2CVddYARXr8gs3CtNp6pQzktOjOp+qbx1y/W8vubAf9V9Qed1hKkB8xArlhHlX7c3wW5UgQrTiS/8oLF/4gsUKCKFIQyI6w8AMExx5vllwBKd8S7VAwZqx6SbaLvNHIIcmwrKPovbh6Q9Xfk3oYPIHupMpx0PJj76GZtnEFESB+I1ux+HNbLfW+FL2pRsXRIrznGkpWDnmIvvnOdPSOUgOsKG+yVIu+T2tfbfKsbsl8JveArgPVwsTDoml+T6FW9AQNAICrbuUr8goXUiLn8Q6uTpHktljWV5thhAksSjk5el5N24j4GY3VQk3w0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(55016002)(5660300002)(8936002)(4326008)(8676002)(45080400002)(478600001)(186003)(33656002)(9686003)(7416002)(2906002)(316002)(86362001)(110136005)(26005)(64756008)(7696005)(66476007)(66946007)(66556008)(76116006)(66446008)(71200400001)(83080400001)(44832011)(6506007)(52536014)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: njvIxFBirT4FV7s8yart0OHa5rx7F+1ldqVfA7ytsZOksqL5JT+aKh2KLGVz1JUkMxItVg8FMCAKQWiYHognc5f+IhS1AfWIBJyedqSshHhsg626R+O+M+TZtejSu4SPyYk7UXqo62G+nHaUoKvNa9zHe3a2070VqLeVWXzJT/XETuim4hOiPfyIZKlw2FcuxjKXXS5ixzqUHV8x65BMdqk+kY0KkTQCQKpV993X4rNdc4XCg6MTuDJ572uiz3uy1M1Z83wrKO8GT/9jkPjZXlEpQoFY5nZmQtIXodXAReRph91DqLqaTIme7wkWGWJDTsPlY6p+av1HVGDn984FzvgdXLfUfwNdrK5qK01a+zBVza1JQc6qRQYwiZt7W2tgxWibWufTafCW+BKashPjKAdR3iPvn6CNBTbH3/6vJ7v8O41P9TYOvS9PDMIVGMND394QQEBYN6lQTqq0+vTlSBDckQAGpOzaAe4wDpM3lOw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d964508d-4c9d-46eb-791b-08d7faf0bda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:00:17.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Qe4TCs5uIXC5VqOSef+vyy/mQoGTsS/xQhDuUYOI8AxOdoC+pRzcyDTkwcWeJ0j4F0w15eUIFnIITDTbvDcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6695
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIE1heSAxNCwgMjAyMCAyOjU0IFBNDQo+IA0KPiBDb252ZXJ0IHRoZSBpbXggdHBtIHB3bSBi
aW5kaW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0ICAgICAgICB8IDIyIC0t
LS0tLS0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnlhbWwg
ICAgICAgfCA1NQ0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDU1IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUgMTAwNjQ0DQo+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3B3bS9pbXgtdHBtLXB3bS55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQNCj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KPiBkZWxldGVkIGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggNWJmMjA5NS4uMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KPiArKysgL2Rldi9u
dWxsDQo+IEBAIC0xLDIyICswLDAgQEANCj4gLUZyZWVzY2FsZSBpLk1YIFRQTSBQV00gY29udHJv
bGxlcg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxlIDogU2hv
dWxkIGJlICJmc2wsaW14N3VscC1wd20iLg0KPiAtLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVz
cyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXJzLg0KPiAtLSAjcHdtLWNl
bGxzOiBTaG91bGQgYmUgMy4gU2VlIHB3bS55YW1sIGluIHRoaXMgZGlyZWN0b3J5IGZvciBhIGRl
c2NyaXB0aW9uIG9mDQo+IHRoZSBjZWxscyBmb3JtYXQuDQo+IC0tIGNsb2NrcyA6IFRoZSBjbG9j
ayBwcm92aWRlZCBieSB0aGUgU29DIHRvIGRyaXZlIHRoZSBQV00uDQo+IC0tIGludGVycnVwdHM6
IFRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBQV00gY29udHJvbGxlci4NCj4gLQ0KPiAtTm90ZTogVGhl
IFRQTSBjb3VudGVyIGFuZCBwZXJpb2QgY291bnRlciBhcmUgc2hhcmVkIGJldHdlZW4gbXVsdGlw
bGUNCj4gY2hhbm5lbHMsIHNvIGFsbCBjaGFubmVscyAtc2hvdWxkIHVzZSBzYW1lIHBlcmlvZCBz
ZXR0aW5nLg0KPiAtDQo+IC1FeGFtcGxlOg0KPiAtDQo+IC10cG00OiBwd21ANDAyNTAwMDAgew0K
PiAtCWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtcHdtIjsNCj4gLQlyZWcgPSA8MHg0MDI1MDAw
MCAweDEwMDA+Ow0KPiAtCWFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQX0NMS19MUFRQ
TTQ+Ow0KPiAtCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnNjZzEgSU1YN1VMUF9DTEtfU09T
Q19CVVNfQ0xLPjsNCj4gLQljbG9ja3MgPSA8JnBjYzIgSU1YN1VMUF9DTEtfTFBUUE00PjsNCj4g
LQkjcHdtLWNlbGxzID0gPDM+Ow0KPiAtfTsNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20ueWFtbA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20ueWFtbA0KPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi5mZTllZjQyDQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS55
YW1sDQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOg0K
PiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHAlM0ElMkYlMkZkZXZpY2UNCj4gK3RyZWUub3JnJTJGc2NoZW1hcyUyRnB3bSUyRmlteC10cG0t
cHdtLnlhbWwlMjMmYW1wO2RhdGE9MDIlN0MNCj4gMDElN0NhaXNoZQ0KPiArbmcuZG9uZyU0MG54
cC5jb20lN0M4ZGJhMGM4YzE1MGI0ODg1OTEzMDA4ZDdmN2Q1MzIwZCU3QzY4NmVhDQo+IDFkM2Jj
MmI0YzZmDQo+ICthOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyNTAzNjczNDUxMDk1MjIm
YW1wO3NkYXRhPVdUNg0KPiBrQTlscFpNQllnUzcNCj4gK3doWTlybFZxNXFEY0daWWhlT0hvVFI4
bnVwT1klM0QmYW1wO3Jlc2VydmVkPTANCj4gKyRzY2hlbWE6DQo+ICtodHRwczovL2V1cjAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmljZQ0K
PiArdHJlZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2Fpc2hlbg0KPiBnLmRvbmclDQo+ICs0MG54cC5jb20lN0M4ZGJhMGM4YzE1MGI0ODg1OTEz
MDA4ZDdmN2Q1MzIwZCU3QzY4NmVhMWQzYmMyYjRjDQo+IDZmYTkyY2Q5OWMNCj4gKzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzcyNTAzNjczNDUxMDk1MjImYW1wO3NkYXRhPUFselQ0YkMzR1pnVg0KPiBj
REpuNXN2TXFqdA0KPiArNUhON0xqNjBGYzdtJTJCM0QwZzB4USUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiArDQo+ICt0aXRsZTogRnJlZXNjYWxlIGkuTVggVFBNIFBXTSBjb250cm9sbGVyDQo+ICsNCj4g
K21haW50YWluZXJzOg0KPiArICAtIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0K
PiArDQo+ICtkZXNjcmlwdGlvbjogfA0KPiArICBUaGUgVFBNIGNvdW50ZXIgYW5kIHBlcmlvZCBj
b3VudGVyIGFyZSBzaGFyZWQgYmV0d2VlbiBtdWx0aXBsZQ0KPiArICBjaGFubmVscywgc28gYWxs
IGNoYW5uZWxzIHNob3VsZCB1c2Ugc2FtZSBwZXJpb2Qgc2V0dGluZy4NCj4gKw0KPiArcHJvcGVy
dGllczoNCj4gKyAgIiNwd20tY2VsbHMiOg0KPiArICAgIGNvbnN0OiAzDQo+ICsNCg0KU2FtZSBp
c3N1ZSwgbWlzc2luZyB0aGUgcmVmZXJlbmNlIHRvIHB3bS55YW1sPw0KDQoNCj4gKyAgY29tcGF0
aWJsZToNCj4gKyAgICBlbnVtOg0KPiArICAgICAgLSBmc2wsaW14N3VscC1wd20NCj4gKw0KPiAr
ICByZWc6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBhc3NpZ25lZC1jbG9ja3M6DQo+
ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+
ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtICIjcHdtLWNlbGxzIg0KPiArICAtIGNvbXBhdGlibGUN
Cj4gKyAgLSByZWcNCj4gKyAgLSBjbG9ja3MNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svaW14N3VscC1jbG9jay5oPg0KPiArDQo+ICsgICAgcHdtQDQwMjUwMDAw
IHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1wd20iOw0KPiArICAgICAg
ICByZWcgPSA8MHg0MDI1MDAwMCAweDEwMDA+Ow0KPiArICAgICAgICBhc3NpZ25lZC1jbG9ja3Mg
PSA8JnBjYzIgSU1YN1VMUF9DTEtfTFBUUE00PjsNCj4gKyAgICAgICAgYXNzaWduZWQtY2xvY2st
cGFyZW50cyA9IDwmc2NnMSBJTVg3VUxQX0NMS19TT1NDX0JVU19DTEs+Ow0KPiArICAgICAgICBj
bG9ja3MgPSA8JnBjYzIgSU1YN1VMUF9DTEtfTFBUUE00PjsNCj4gKyAgICAgICAgI3B3bS1jZWxs
cyA9IDwzPjsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjcuNA0KDQo=
