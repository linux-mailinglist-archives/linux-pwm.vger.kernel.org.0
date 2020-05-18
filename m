Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293A61D709D
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 07:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgERF6t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 01:58:49 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:6066
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERF6s (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 May 2020 01:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUe5cazUTcM+RLf3FiGAZQqMlId1bFg30a1gPDSrDKW15+PdmGSRtxR5gwayJg+MEdwC3NSqGTyPAX4bzPWmKu+hzo02Y2nczmuAQlcRSFKQYaQM/FW5R5VDkASL4OlBmXue+mWZPA078qsuCITRJwIgFMifd1wbaP2YlIqQn5KHtcZW53EPyrl0ksSd4CLeLTOrCM8qRtK45r6CQ0TOhJUSgIUeChVmoYvazUkXNz5rfPDVs4BSqHhozlfJnqs+kSnJ9xcOyrPHhySlK05ASpDYbdNudSPl3nkhHRZ6Mcc0RLCeMbaI9ag1dvEvZJZhFejMpNWzl7cC72vvi8JqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJZIY/Rjm/TYK27OSIKn4TjYU1agnKvXvjV2qQoQuOk=;
 b=D/n0u7VEM+Y34wuaHdgM2c0Qbg3ywRxuTgLQNNoEAxX7kNP+hR41BnWrxauQx/k+nROieyXPCerR++NLfehsdNWgXu+15ySBRnyeenFTslYJ3xwMoYn7Kx7oYcTYBpYzoa06U06dOGWLo0gJMAQ8xV52gMCeM0ty3II7FiaHSfv+JL4ZfYJHGkrLUwEq0CA7tZN2hl9fuUZzqDxPL1Ub+lRdJeXpkeQ440j+hTV4ASXjOoE8NFEydtgpT19T6fyKICH2JLF0RCVL09dok5SMzHFzD2+x3EjNA4rIhPiQluQu9PUb3vq3B1+AgB1okveh4HZn8ep9wN2kfjbIreW/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJZIY/Rjm/TYK27OSIKn4TjYU1agnKvXvjV2qQoQuOk=;
 b=MVHq3nPCBLR3K5pLD7a+BUPYegGUDfGb6mJ10f9Y66gv0TS2wI/F9Gj+CIt/nQc0Jz61+/Gc5u4SwPwNX+NLGI94iQXp81f0uOZugm7P/rwki/vqhnxBV/CQ8UpLWjhvHMM9IJ0BH9O00TLbw53nMMSCpYxufP4SmZBM1vAETMk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6695.eurprd04.prod.outlook.com (2603:10a6:20b:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 05:58:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 05:58:42 +0000
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
Subject: RE: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Thread-Topic: [PATCH 1/2] dt-bindings: pwm: Convert imx pwm to json-schema
Thread-Index: AQHWKb3TVkIQx8/F2EitnEjJu59w0aitXsSg
Date:   Mon, 18 May 2020 05:58:42 +0000
Message-ID: <AM6PR04MB4966EC7122B2BFB9FEEDD74280B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589439259-28510-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10d899b3-57e2-420b-8853-08d7faf084f1
x-ms-traffictypediagnostic: AM6PR04MB6695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66954585DC137D45E44C5DB880B80@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pc75P+qcqR+TU9CE6xvpv3oCLFZyuKlhP8jOCi7rpcKIyRPWd/Zgix7oAEGuzNLnoZpfFvY9IDRxPAnQoCipVV8rnfIIy5qPeb8g6nnsCvNLO63gFHAle+Nkwr/IpBgKavLMfBff5B8RR1WpwvYgUEcbVVs/umg6AKOxn4oUPB5LeYO0yyAw0YTs/medIfb5dK69ACVDszyFeYM9+44pWtZz8pro9mCb+pWnxnJCsclZzUUNvk+Gpi8UUzLiN+UBL8aMrIlpXvbc2gI1kLevu85UVTp4/+/xK7ELKRHNcaa7RTTclrGFnuU/EfsfKZRYXceBiaSnesd/1EZ7WTWVEXdNrOVTgb67yL0ipxMLSfYHA/MZtqAWQkj92B8bHrXO1dA2E+4mBMZn2b9Uxag+PxRNt+GM6NmKoCTYlEX8XnTUlThkI6LZEtef3rFNWyHv6epJPkoCc93y4hwiKr5Crx/HF/k69kB5FsEwre90HgcJjeFk3/2rp410e32Q2uzDvYvDrSBvGav6kvaKscYqkrRQ4kqZKmd0YmaAXc4kLSmNRNCg7We9/mO4kBkBYlME
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(55016002)(5660300002)(8936002)(4326008)(8676002)(45080400002)(478600001)(186003)(33656002)(9686003)(7416002)(2906002)(316002)(86362001)(110136005)(26005)(64756008)(7696005)(66476007)(66946007)(66556008)(76116006)(66446008)(71200400001)(83080400001)(44832011)(6506007)(52536014)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ozbQHlUI6rg1IaJYeVodMmu1rIps8SbJrKc3nk7zGa89hLxB9k9NMc/h3ohihpxifWRZ0OVaU0ucfrgClJdG/kEglMG1N2NKfJ3Feg4WbSnCn6lGGQPZi7Sz5g+1/mHbPnYjhijAh/OT8B58m7+2HsvfYTHd8myAzVQO7Baz4IZaplZTMhT+VBaeIGqs5Ie3vVzdZ0MLdbsytVrDGktPEbtZrjDV2auAZiia4hkCpuOaEtuQYLCEBM/U8TKWsnp4jhbqVmBofAfIu1jNdkTYEcimLNLJyn0irepGQB6sVoX2IiVhpHDUk7Q4RXInG3aLMTEekDeD/fuoNLJMtW12pLFx8MKR3hjNxvAlnhUFhBzJLbyyZsImIPfjxPsQLQehs6a33OhWKY0SjLftvompec+0rmyoaX2i+YDO5lMZFXjjawoTazl6e71S+faB4RkRn9PLq2dV9Xps0Z2hjKlDNaBPxYQFiCekrlgnNAIEe1w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d899b3-57e2-420b-8853-08d7faf084f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 05:58:42.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKUbqVivu7B7RU3yU7lvJbIrB74eXER47Xq6OP7vQG/07PtWrlMNZstHQJxvygpNZiTsXXlPVlYIyHTQLZ5JaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6695
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIE1heSAxNCwgMjAyMCAyOjU0IFBNDQo+IA0KPiBDb252ZXJ0IHRoZSBpbXggcHdtIGJpbmRp
bmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQgIHwgMjcgLS0tLS0t
LS0tDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS55YW1s
IHwgNjYNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2NiBp
bnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0DQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgt
cHdtLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcHdtL2lteC1wd20udHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9pbXgtcHdtLnR4dA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MjJmMWMzZC4uMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcHdtL2lteC1wd20udHh0DQo+ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsMjcgKzAsMCBAQA0K
PiAtRnJlZXNjYWxlIGkuTVggUFdNIGNvbnRyb2xsZXINCj4gLQ0KPiAtUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gLS0gY29tcGF0aWJsZSA6IHNob3VsZCBiZSAiZnNsLDxzb2M+LXB3bSIgYW5kIG9u
ZSBvZiB0aGUgZm9sbG93aW5nDQo+IC0gICBjb21wYXRpYmxlIHN0cmluZ3M6DQo+IC0gIC0gImZz
bCxpbXgxLXB3bSIgZm9yIFBXTSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9u
IGkuTVgxDQo+IC0gIC0gImZzbCxpbXgyNy1wd20iIGZvciBQV00gY29tcGF0aWJsZSB3aXRoIHRo
ZSBvbmUgaW50ZWdyYXRlZCBvbiBpLk1YMjcNCj4gLS0gcmVnOiBwaHlzaWNhbCBiYXNlIGFkZHJl
c3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lzdGVycw0KPiAtLSAjcHdtLWNl
bGxzOiAyIGZvciBpLk1YMSBhbmQgMyBmb3IgaS5NWDI3IGFuZCBuZXdlciBTb0NzLiBTZWUgcHdt
LnlhbWwNCj4gLSAgaW4gdGhpcyBkaXJlY3RvcnkgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhlIGNl
bGxzIGZvcm1hdC4NCj4gLS0gY2xvY2tzIDogQ2xvY2sgc3BlY2lmaWVycyBmb3IgYm90aCBpcGcg
YW5kIHBlciBjbG9ja3MuDQo+IC0tIGNsb2NrLW5hbWVzIDogQ2xvY2sgbmFtZXMgc2hvdWxkIGlu
Y2x1ZGUgYm90aCAiaXBnIiBhbmQgInBlciINCj4gLVNlZSB0aGUgY2xvY2sgY29uc3VtZXIgYmlu
ZGluZywNCj4gLQlEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2st
YmluZGluZ3MudHh0DQo+IC0tIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBwd20g
Y29udHJvbGxlcg0KPiAtDQo+IC1FeGFtcGxlOg0KPiAtDQo+IC1wd20xOiBwd21ANTNmYjQwMDAg
ew0KPiAtCSNwd20tY2VsbHMgPSA8Mz47DQo+IC0JY29tcGF0aWJsZSA9ICJmc2wsaW14NTMtcHdt
IiwgImZzbCxpbXgyNy1wd20iOw0KPiAtCXJlZyA9IDwweDUzZmI0MDAwIDB4NDAwMD47DQo+IC0J
Y2xvY2tzID0gPCZjbGtzIElNWDVfQ0xLX1BXTTFfSVBHX0dBVEU+LA0KPiAtCQkgPCZjbGtzIElN
WDVfQ0xLX1BXTTFfSEZfR0FURT47DQo+IC0JY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+
IC0JaW50ZXJydXB0cyA9IDw2MT47DQo+IC19Ow0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20ueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwLi40YjYyYWYyDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnlhbWwNCj4gQEAg
LTAsMCArMSw2NiBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6DQo+ICtodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RmRldmljZQ0KPiArdHJlZS5vcmclMkZzY2hlbWFzJTJGcHdtJTJGaW14LXB3bS55YW1sJTIzJmFt
cDtkYXRhPTAyJTdDMDElDQo+IDdDYWlzaGVuZy5kDQo+ICtvbmclNDBueHAuY29tJTdDOWI1Y2Mx
ODE0YTRiNDdkMWNiMGQwOGQ3ZjdkNGY1OTQlN0M2ODZlYTFkM2JjDQo+IDJiNGM2ZmE5MmMNCj4g
K2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MjUwMzY2MzMxNjI3ODY1JmFtcDtzZGF0YT1NMlJQ
Y3R5DQo+IHd6NjFXWnJwQVc2Uw0KPiArTzNOSmJyMndqMnFYd25NTW1Cd0NiSW5rJTNEJmFtcDty
ZXNlcnZlZD0wDQo+ICskc2NoZW1hOg0KPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpY2UNCj4gK3RyZWUub3JnJTJG
bWV0YS1zY2hlbWFzJTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTAyJTdDMDElN0NhaXNoZW4NCj4g
Zy5kb25nJQ0KPiArNDBueHAuY29tJTdDOWI1Y2MxODE0YTRiNDdkMWNiMGQwOGQ3ZjdkNGY1OTQl
N0M2ODZlYTFkM2JjMmI0Yw0KPiA2ZmE5MmNkOTljDQo+ICs1YzMwMTYzNSU3QzAlN0MwJTdDNjM3
MjUwMzY2MzMxNjI3ODY1JmFtcDtzZGF0YT1VeGdZU0NsYW55T2p0DQo+IEJtbHlOck1aeUYNCj4g
KzMlMkY1YXdEJTJGTTN5YVZQcWdOS2d4cyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiArDQo+ICt0aXRs
ZTogRnJlZXNjYWxlIGkuTVggUFdNIGNvbnRyb2xsZXINCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+
ICsgIC0gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gKw0KPiArcHJv
cGVydGllczoNCj4gKyAgIiNwd20tY2VsbHMiOg0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsg
ICAgICBTaG91bGQgYmUgMiBmb3IgaS5NWDEgYW5kIDMgZm9yIGkuTVgyNyBhbmQgbmV3ZXIgU29D
cy4gU2VlIHB3bS55YW1sDQo+ICsgICAgICBpbiB0aGlzIGRpcmVjdG9yeSBmb3IgYSBkZXNjcmlw
dGlvbiBvZiB0aGUgY2VsbHMgZm9ybWF0Lg0KDQpTaG91bGQgd2UgYWRkIHRoZSByZWZlcmVuY2Ug
dG8gcHdtLnlhbWw/DQpCVFcsIHN0cmFuZ2UsIEkgZGlkbid0IHNlZSBmb3JtYXQgZGVzY3JpcHRp
b24gaW4gcHdtLnlhbWwuDQoNCj4gKyAgICBlbnVtOg0KPiArICAgICAgLSAyDQo+ICsgICAgICAt
IDMNCj4gKw0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtIGZzbCxp
bXgxLXB3bQ0KPiArICAgICAgLSBmc2wsaW14MjctcHdtDQo+ICsNCj4gKyAgcmVnOg0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAg
LSBkZXNjcmlwdGlvbjogU29DIFBXTSBpcGcgY2xvY2sNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246
IFNvQyBQV00gcGVyIGNsb2NrDQo+ICsgICAgbWF4SXRlbXM6IDINCj4gKw0KPiArICBjbG9jay1u
YW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IGlwZw0KPiArICAgICAgLSBj
b25zdDogcGVyDQo+ICsgICAgbWF4SXRlbXM6IDINCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtICIjcHdtLWNlbGxzIg0K
PiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4gKyAgLSBjbG9ja3MNCj4gKyAgLSBjbG9j
ay1uYW1lcw0KPiArICAtIGludGVycnVwdHMNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svaW14NS1jbG9jay5oPg0KPiArDQo+ICsgICAgcHdtQDUzZmI0MDAwIHsN
Cj4gKyAgICAgICAgI3B3bS1jZWxscyA9IDwzPjsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJm
c2wsaW14MjctcHdtIjsNCj4gKyAgICAgICAgcmVnID0gPDB4NTNmYjQwMDAgMHg0MDAwPjsNCj4g
KyAgICAgICAgY2xvY2tzID0gPCZjbGtzIElNWDVfQ0xLX1BXTTFfSVBHX0dBVEU+LA0KPiArICAg
ICAgICAgICAgICAgICA8JmNsa3MgSU1YNV9DTEtfUFdNMV9IRl9HQVRFPjsNCj4gKyAgICAgICAg
Y2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+ICsgICAgICAgIGludGVycnVwdHMgPSA8NjE+
Ow0KPiArICAgIH07DQo+IC0tDQo+IDIuNy40DQoNCg==
