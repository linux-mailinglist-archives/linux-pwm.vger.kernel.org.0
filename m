Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C026C7FA
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2019 05:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbfGRDfL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Jul 2019 23:35:11 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:15744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389169AbfGRDfL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 17 Jul 2019 23:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkgR9iqEAW5NpcG4smqRCOL5BGzDp+3mVN24eiRV0pG9cT3GBgHqGXN1tO7VIP7ur/kcGGbsWZTgufO3SNP6GKA0Pscw+g5/B9slyAiQXrP551l8+bFaJOlqQBUZO7yYhBqc0PLKHljh5/MFoDZDbsG8OPyajmnNuL7zNX8m4x6A9cVi/xUFoGOr0RmK73k4O0wAk5UhzX7YTgVfzISy8NZngeUDslq7SWxOB1BnSgOmmOQJsR6YPdnaCd69J625j18FiJRyygUvDweARuXMr3ZksSfbkhpEWaOUtPDtedrannFjTgVEcQamu5h6N87vJ9CEFxYVBshhLpZlhJjyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHZHlNb4ImKb33zjo9erH3xdC8nL8I4j0EVNsMzrglE=;
 b=SMMybDDO+kqw4gMlP37uW3ZdVshrybGY510jIwvZKefRVMRWrsVaUnRhoDmANfKqwsfmj10TeQ1ztz1FYP4p00C7doUmuTzpOpWDFR8k6rcG4mAamcSK/7yjl2D9m1JHrX7N3KmeH8ZnduRslqRDUP8wlrgqK+4u8yFgPE7ofoVgDv1hLUmMPRB7ghqhI236/QxpRBmu2RwcCO/uUJP3Hz13ZcI8uWgkyxCOxeZUYLs2xcxunOzxxMRBpaDP78opUglQ2rzZ61Vwx7X9sJctD28dEKPHFZ90UJpYFcWsn+3KJnkaObwWmZKDJzYMZvi1Fs0FSgTBdIHoI/cliIQvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHZHlNb4ImKb33zjo9erH3xdC8nL8I4j0EVNsMzrglE=;
 b=T/qauvZiIDJ/xCAe2p9HzGFLcKjPzS/FVwmbe80POj3tw2pCm3HeBHS1khDlO8wUhUdqrEibnfhwl8sqCMixCV6FDSn+7jEs2EesVKJXiqyL7qwTiHFicH/e3d+w6BATljRWNvZYqBCEQSuVnsk5oivOcJfhOfo6OZmmRo0u4UQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5857.eurprd04.prod.outlook.com (20.178.118.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:35:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:35:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHVPQnp5eWkyfCnPUOOHDKzmqO/vKbPuWDQ
Date:   Thu, 18 Jul 2019 03:35:08 +0000
Message-ID: <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
In-Reply-To: <20190718013205.24919-1-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd5b1787-6ca4-4a5d-1d48-08d70b30ee7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5857;
x-ms-traffictypediagnostic: AM0PR04MB5857:
x-microsoft-antispam-prvs: <AM0PR04MB585769C41BAB2C773EC3C74280C80@AM0PR04MB5857.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2501003)(66946007)(76116006)(66476007)(478600001)(66446008)(64756008)(305945005)(55016002)(11346002)(14454004)(9686003)(52536014)(25786009)(6506007)(186003)(74316002)(71190400001)(229853002)(558084003)(26005)(71200400001)(102836004)(6246003)(5660300002)(53936002)(4326008)(110136005)(316002)(7736002)(68736007)(2201001)(256004)(86362001)(99286004)(476003)(7696005)(44832011)(486006)(76176011)(446003)(81156014)(8676002)(81166006)(6116002)(3846002)(8936002)(33656002)(6436002)(2906002)(66066001)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5857;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A84BvW8Xdot4HuHsS2AfsGmAph2GlEqD9F1wQJzvoPDat2gSOTqqyk46GcliZo5/4mp7PGyTimyooiyDa6bNr6P+Vj3dXkclgtpUm7A4EJfLf1avQlbx6IdVuP8CcRZcsZ6llf74W0IAjAphwI3iJgFc5BRjURMTyx8KmamPO9vWVxPuQA3CJTUSU1kpnz6TdIdyrS2JVBochlmlrzODfQd7cYmEu/5N5waQEiwCoXCunQzrgPvr5CrVLtKD6qOegzLDWk7F9mLlkwGDCrEZehtEUakwmwGAgJcfZcpgBbtbObwrPmaWcbOtZOe1yPcxAU3RQdy/a/DWP+lC02RUgNA1jjut8+QuCPvqLQd+q1J0SZNetWUpXKv+bA2kgXGoIF47ioEbn6TTAGAtI56Qik87ewNawMY8467EVTm6c9s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5b1787-6ca4-4a5d-1d48-08d70b30ee7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:35:08.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5857
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgSnVseSAxOCwgMjAxOSA5OjMyIEFNDQo+IA0KPiBVc2UgdGhlIG5ldyBoZWxw
ZXIgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgd2hpY2ggd3JhcHMgdGhlDQo+IHBs
YXRmb3JtX2dldF9yZXNvdXJjZSgpIGFuZCBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhl
ciwgdG8gc2ltcGxpZnkNCj4gdGhlIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8
YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg==
