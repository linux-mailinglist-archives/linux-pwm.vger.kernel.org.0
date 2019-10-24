Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DEE2AF7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406998AbfJXHUn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 03:20:43 -0400
Received: from mail-eopbgr1400114.outbound.protection.outlook.com ([40.107.140.114]:6209
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404514AbfJXHUn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Oct 2019 03:20:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3OVHRq/LhJKYNO4/MrfChW6EBnQ/CZVKEQRM95pc1PNgmkd6qDRFMrLrTQ0f2CCVGIHR/vJUHqYW71e5qP60aDNmH4uXunnRbnlS9uXd9lipvPRlcxFWWJIOUZf+LxV6oHsooBEkFMOW4ZSKfei1Oj4WPG76CQ49qnz+0kUJl8E+v7mc9SGb6RfQdzF5Ke7Hk9ilgv2v0RC9aHkWM26BMflNKBimnB2sF6yjvbyOI4pbEaLuB+sRNIra9MU/BdgiW3E8VOoUH6YJdCbKJF6/pT1cu77lEGwKrZswhuzbedXo5cHb07fV96Fpv2WIk1oaZMSEvx1rhYiiobl6kztTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsDryiF1X175nxavEOiDtpBPJuxVX/KHlP+My9ZPgHY=;
 b=dwwPZGR32EFFwl7+7t/Y7P1j2CqwX6g04jEuqcLN7irjjp1SfOwV2DNp3I8yi0ok/zkH5bdemkOk0e6oy6MrKzarncf9zbOuuv1jRzdc0eK8Nw/mhJzFyqSw3QLfusevYo0O45nTJZgQUBsizCWSMoVMrjPPY10Lwb29rPHX5O04UgjbQTUPeiGv/BiTNAOLR5RLxuj+kI9aRxNconWtIae6SjW8Urg0CZhOwFeZ/+i7Cs3zzRRoXe+zOr5M+NRtFOhCdxD3L9IsrnJUXo5erJ4X8jdO4ZeKI8it74ywRftpLmcT2yX/krQqe7lCxDt2TZVCh54D9/jPTetfqioW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsDryiF1X175nxavEOiDtpBPJuxVX/KHlP+My9ZPgHY=;
 b=X4SDNi8tQSZE4+q5G/mpGEDOJNvHkXkvHQQmQagqbtwVmIcOOlmQZK7wWEg0gcmArCK7tgpkdG1z6XENo8rpXAviOvzgUBKlbDh547SfEGeivF14ye2UsctPrOSU2mQHLgm9sDPAGLdkacHyW44AVF+A7AcD4KMOJWa7fhFEMo4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4799.jpnprd01.prod.outlook.com (20.179.175.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 07:20:38 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2367.025; Thu, 24 Oct 2019
 07:20:38 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 1/2] pwm: rcar: Drop useless call to pwm_get_state
Thread-Topic: [PATCH 1/2] pwm: rcar: Drop useless call to pwm_get_state
Thread-Index: AQHVijqp6ZvCByItY06ztcr+nNerrqdpYiOg
Date:   Thu, 24 Oct 2019 07:20:38 +0000
Message-ID: <TYAPR01MB45448F3C84960A52B3FC20E5D86A0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fdd23ee-cce1-473b-f453-08d75852ab77
x-ms-traffictypediagnostic: TYAPR01MB4799:
x-microsoft-antispam-prvs: <TYAPR01MB4799C6A6C91BA73D23F31620D86A0@TYAPR01MB4799.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(54906003)(99286004)(256004)(110136005)(316002)(6436002)(229853002)(305945005)(7736002)(74316002)(478600001)(33656002)(55016002)(6246003)(9686003)(4744005)(5660300002)(52536014)(71200400001)(71190400001)(2906002)(6116002)(3846002)(86362001)(4326008)(7696005)(66946007)(26005)(76176011)(25786009)(186003)(102836004)(6506007)(66066001)(76116006)(66476007)(66446008)(64756008)(486006)(476003)(446003)(81156014)(11346002)(81166006)(8676002)(14454004)(8936002)(66556008)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4799;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvRHAn7GElMQSNUMFMDAb/4PT1TVDSl4O8hrEpLDUPUNSYQOLppzGaWbjU1G/8hIxL7J/5m6ypeGoEpkS82g4T7+JJrfR5oxUrCEfsy2mvwX72V3T5wcDoIokcbi7h4aoq5ij1Gv5x2LQNPrAcMW8L2OpsVkmbcs2yCKUm6HBHYocfWP2nE823+uybGKUpPa7/AqpmnNahb/VYtzakZvTt89auA7ls2iO4DTvNgsVJOw/+BRLbSG8xpTXYg+4x1xgqnDurs6462FKIIy/y2BR7FqVaVYtuvgZihRPE1vodiKWO0mM6dlKT+x7FFx9x2ih2uluVs0LeKMcBxzRseqQ6Hlbo97TIhUIY8OgD4l62cIqv9qp4P+7reEmq4O/asSUI+KVITsoBCDIh3B46lpx4ErRPrjeabbFwwm8vCFK027dbXZzhaaRMJYBVXEj7Lc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd23ee-cce1-473b-f453-08d75852ab77
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 07:20:38.1853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19hO/ExJKj0c0VEDU6KrGw5W0pz8fpofm7SZOidBS39O/cunYYnlZTZDKjmbL1Mh7FzdunkMFGyvvB1dHR58VnxEIwBAaA4uwfLC+vAHj/irnFiguDxazNrRU+gxlWbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4799
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQo+IEZyb206IFV3ZSBLbGVpbmUtS29uaWcsIFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDI0LCAyMDE5IDQ6MTQgUE0NCj4gDQo+IHB3bV9nZXRfc3RhdGUgaGFzIG5vIHNpZGUgZWZm
ZWN0cyBhbmQgdGhlIHJlc3VsdGluZyBwd21fc3RhdGUgaXMgdW51c2VkLg0KPiBTbyBkcm9wIHRo
ZSBjYWxsIHRvIHB3bV9nZXRfc3RhdGUgYW5kIHRoZSBsb2NhbCB2YXJpYWJsZSBmcm9tDQo+IHJj
YXJfcHdtX2FwcGx5KCkuDQo+IA0KPiBUaGUgY2FsbCB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQg
N2Y2OGNlODI4N2QzICgicHdtOiByY2FyOiBBZGQgc3VwcG9ydA0KPiAiYXRvbWljIiBBUEkiKSBh
bmQgYWxyZWFkeSB0aGVuIHdhcyB1c2VsZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCg0KVGhhbmsgeW91
IGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBT
aGltb2RhDQoNCg==
