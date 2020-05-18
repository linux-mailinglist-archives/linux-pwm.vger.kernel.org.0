Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A321D70AD
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgERGHK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 02:07:10 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:6080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERGHK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 02:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3UXY4lz7i8GAosW/ApyJn27AXVZVQqKs1O+sLdb3Fg+crMwvwHfxonC7HHOmk5xsBvfdVtxXcRyPB27OaEG96YN7FEg3F7v+t4kiVTKkdNz6MFPsu+huuPP9G06+k4+QB8horrCCzwbOOJ70JI/43KN6bO6yneI8CR9kVltGPFWF46a311R4krFRNRJ8bFJrARW8YLA25ePJUFeqW2GwJqzW5Q1/T0C39FfztWRPK/oefQSxKyiLJOUVAq4rBetBKanjuFCPFZkUTy+ja2vA02Yf+1dEJt0lVimuvYKRHvahjhTHlV1v3y4bpKJi/FP3FVl6A0uPXvngpnDgcYwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ST0tZy0Y7rv0d8NxB+N3vkZm/udbm7FfXU8+17PmPg=;
 b=Fav430/KKfjsAsl2LTHVgf80HTI4+D8J8uie4SKJSuhRNKKYh6Q4KlP9pf/YpAWpSvQ8PoaUGmuWWCqrcj7QOmXif3B5Gx/XB+yiWdtR5koQyMCUIX3xaU9EGJZfmhe0xdmVQmVOZkl1TSalPPtebIA9nin0oIp9LD4Rln7JaTz+QaPgrjNg5kTkjiavAxQOUEbJ6y6DSYii1so6AL9OvN5fFjoh0Zu3yUM1FCJqw5bu4o4oZJPhy+X1tWvhwZczN1F3hzm4aSmV1Hjur4iVj+KUmmEBVYfDnmAlYLwpg3RzF1RT5GBqnJS8NY80+uj3X/zdPdlqXmSSYabCmuxO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ST0tZy0Y7rv0d8NxB+N3vkZm/udbm7FfXU8+17PmPg=;
 b=EpyjcPUtZJ4lrV0ZbcM5esdVkF9/ATyJuQPIu1xv+hjLMm9AffHE1et4AF9dObl1yXHUBlt4XcsAuG8kmIdhDGw3JUIrLD4oWtfWCnN7cPUvH5NJ4sOgOE/IhyFyn+IyHo4ApJR+3/9CnXzsgka+SKeUJY30HWvjSEiRcQOHIlo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6695.eurprd04.prod.outlook.com (2603:10a6:20b:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 06:07:06 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 06:07:06 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Thread-Topic: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Thread-Index: AQHWKeXny41UDiiW/0yEHY+vY7fj6qitPUuggAAaI4CAAAlg8A==
Date:   Mon, 18 May 2020 06:07:06 +0000
Message-ID: <AM6PR04MB4966D0851412CE57C860B63C80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B92CFFA23DD77748C77680B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916B5980C0681BFF3C08FE5F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B5980C0681BFF3C08FE5F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b331b911-28bc-4f9b-cf7a-08d7faf1b131
x-ms-traffictypediagnostic: AM6PR04MB6695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66959CA5D8DC1DE3B23BB28C80B80@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrXs1gPjk5TV0iMEeCHY6Cdi/aLbRiqbx+KPHcB/vi+DLIulF7yuqS8Cf5W3ZW9MmfNAiGgIGMMSL2VxsjRtCiWRPfc6gVxd5I6TLY3CmL3HOMnY6w/c62vvAfKK3Yph+yuYZr88QSxIMeuf8L/EP/ZGDJYW4lZ9q3SVGUQpUdLX0kFfc61ZqFdYHoi74UAMSDei9ko0Byhz9CPd1tnwP6zJNE4tDlHtB4FrWquog7cuk74c17ottf6ZZJwKNagqKxrqG2SYMVAoLvaTBBefuRZ4tsMUsyWRYXb9j4hKzb+6q6tSvjEuRyIkw1KijficqJ24n2TaNYuf98c8v5E9vdLJk5O7gBYm9gTV2THJo6eRUm9ZTNYdT2NVCTWpGszcIejYrZdBOTVMK4NKW+pSJ6vvnJBPxF4cPQAvfv048GhDoImAgw+JiteEbMsMRtIansbFzLkqTiVnDhwPMLStTbs9yIfeCsihpWy3Is9NSrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(4744005)(55016002)(5660300002)(8936002)(4326008)(8676002)(478600001)(186003)(33656002)(9686003)(7416002)(2906002)(316002)(86362001)(110136005)(26005)(64756008)(7696005)(53546011)(66476007)(66946007)(66556008)(76116006)(66446008)(71200400001)(44832011)(6506007)(52536014)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OWEyHn2laRt9Bf08PTNvL8QJkJiHql6pLIFZ+9mJb4M345UEZGs8dhgb4WB8aEC20svmGXSZJV81QU5C0VTD8DKsyVpMHOrZEwX54Aky2v7kKDbiGn7dsQeJfKdYIY50SNoHIlL8zwRXH92/lSeTYnZfkl9gxrKaud5icXCjVR/RLTh6fImrvhtOLL6m1u9xcsvTaMUfiTkaBUdR1WhK7rDdTGdWJE+Q8Q/jC82yDDOngqklgSTHjcAkf7F78D4AzW9o4oa8JrodZAS9jmAaL4mTDFUQNiMIFArZ69s6jyjo0Chbc+B8V2E4CvnbV+ANoM7JuOKVf8Ys9udWsEXi/kcUZiKBllTZ2RwIGj8cbl7iW+fhBVxbMRt+Qwm8BgH+CfmcpFr/R/5dD5tuUwyncYhyauOsCJEOFuwLqUaIqkBlpJZFi3HoZy7pCSc8/zONqZRkYBlPbDlVbfTq90JIwP8zpKlDPQSVc8vcpVr04aw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b331b911-28bc-4f9b-cf7a-08d7faf1b131
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:07:06.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyTdADYB0dCnezrAH613pc1I7rwhgRcwMlWb8I5gQ4PePndHO5Ins2+MLbaZpTGWniUs375i6/FISezrn568Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6695
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTozMiBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkdC1i
aW5kaW5nczogcHdtOiBDb252ZXJ0IG14cyBwd20gdG8ganNvbi1zY2hlbWENCj4gPg0KPiA+ID4g
K3RpdGxlOiBGcmVlc2NhbGUgTVhTIFBXTSBjb250cm9sbGVyDQo+ID4gPiArDQo+ID4gPiArbWFp
bnRhaW5lcnM6DQo+ID4gPiArICAtIFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+DQo+
ID4gPiArICAtIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gKw0KPiA+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBlbnVtOg0K
PiA+ID4gKyAgICAgIC0gZnNsLGlteDIzLXB3bQ0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgIiNwd20tY2VsbHMiOg0KPiA+
ID4gKyAgICBjb25zdDogMw0KPiA+DQo+ID4gU2VlbXMgeW91IG1pc3NlZCB0aGUgcmVmZXJlbmNl
IHRvIHB3bS55YW1sLg0KPiANCj4gSXQgaXMgYmVjYXVzZSBtYW55IHB3bSB5YW1sIGZpbGVzIGFs
c28gaGFzIG5vICIjcHdtLWNlbGxzIiByZWZlcmVuY2UsIHNvIEkgYW0NCj4gTk9UIHN1cmUgaWYg
aXQgaXMgYSBNVVNUOg0KPiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3
bS9hbGx3aW5uZXIsc3VuNGktYTEwLXB3bS55YW1sDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wd20vZ29vZ2xlLGNyb3MtZWMtcHdtLnlhbWwNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pcXM2MjBhLXB3bS55YW1sDQo+IC4uLg0KDQpJIGd1ZXNz
IHdlJ2QgYmV0dGVyIGFkZCBpdC4NCkxldCdzIHdhaXQgZm9yIFJvYidzIGZlZWRiYWNrLg0KDQpS
ZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+IEFuc29uDQo=
