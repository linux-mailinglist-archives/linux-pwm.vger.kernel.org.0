Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5EE2AF8
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404514AbfJXHUo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 03:20:44 -0400
Received: from mail-eopbgr1400114.outbound.protection.outlook.com ([40.107.140.114]:6209
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406821AbfJXHUo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Oct 2019 03:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8xiBB+c7tJoItGYA+FTeI9i249qpzQzcdsMDC8dM06lxi4Xk3FSS71HL1Z58GZlEqnWlXSjyjvpvb9F2KrgqoS8fUPdvT4SZsV7+eVX4HBuprAwPKEwl1VUgdMPHpM50O8z/WKzbq1ycnkJTeqxgAlR0XWnUwhlfiW92FAfONmLX4pP3AJnGXlaL8OQ8t5zSS1VCuqEbLvTmTHs3vopya0+/eSXsmhFBggTeT6yj0liX80jhSRGCey0SYpX9ivIm8I/tfICfTysMnC0jZymt1b5vxRkwCIG5lU2tHaVVw+1ZyjuSkMKUdY9N4WoKPXXg1vxFyMhPUUXCehN/36prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjM9sIiU14ord2a5alxXjksAzoD5K/qVxxAODgfjmvI=;
 b=WYMKt42XSLFngpeklE3hg1VMJReo2hreVRmXLAmVnQP8C34NQB0KLyOi1p9lUJH80GN3s3MA996WKCi2FJiaJja02Nv59w/SzzorqBB9OBywyZ5/cV+BvAdVhIpMNmwLQq7x+nyZ5bQ8RU1CraX/BuEGeO47tNBAoTrUsszU6OW4/VMrNazE6UVrMnldb8QxLfjOPsJ82O76yJoN1vIgrqnphDwjmB5a+LNEPdiJmwGxEqNb69PnBL+zT/QwyGJwWAehNSnnVrEClRSWTf2TbMXt6tuL9RVdeVI8aBhiJnj5b/DnK8BelGEMDad5TXBLQtJ9OicPuKSH0GoEAysDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjM9sIiU14ord2a5alxXjksAzoD5K/qVxxAODgfjmvI=;
 b=mYyISoOUqTbR9uj12rZ/5/8lKKy9JK+THU6MdGFtE5/6oNQsTfB/xUlm7DQSYyALClkk0AcOaBheuh8QZE3i+ZDjel/CLMZmjp0y+ssflWTsglHcuB6JLl9bB0jPX6RBUoQBl6J/re92uwRKLcZV/ZfVdDxf0JUNYuWQau+NYNs=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4799.jpnprd01.prod.outlook.com (20.179.175.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 07:20:40 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2367.025; Thu, 24 Oct 2019
 07:20:40 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 2/2] pwm: rcar: Document inability to set duty_cycle = 0
Thread-Topic: [PATCH 2/2] pwm: rcar: Document inability to set duty_cycle = 0
Thread-Index: AQHVijqpakkZsBL++kiNL6xgtM29aadpYl/w
Date:   Thu, 24 Oct 2019 07:20:40 +0000
Message-ID: <TYAPR01MB454494C4434DC0B38AD3E7F7D86A0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
 <20191024071410.30620-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191024071410.30620-2-u.kleine-koenig@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b73500a3-e1e1-4417-43ba-08d75852acd4
x-ms-traffictypediagnostic: TYAPR01MB4799:
x-microsoft-antispam-prvs: <TYAPR01MB4799A4FE03C909A533D97AE9D86A0@TYAPR01MB4799.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(54906003)(99286004)(256004)(110136005)(316002)(6436002)(229853002)(305945005)(7736002)(74316002)(478600001)(33656002)(55016002)(6246003)(9686003)(4744005)(5660300002)(52536014)(71200400001)(71190400001)(2906002)(6116002)(3846002)(86362001)(4326008)(7696005)(66946007)(26005)(76176011)(25786009)(186003)(102836004)(6506007)(66066001)(76116006)(66476007)(66446008)(64756008)(486006)(476003)(446003)(81156014)(11346002)(81166006)(8676002)(14454004)(8936002)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4799;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 362+KvcjXApB4j8EhWzuPqB3IWGb14dR5Mwlz2InJspNLjTxB+SiXGEgB4UG69is4iimSnPJcrrOBXFgtIhT46gKojh7Mrp07ju+KEGFuwfUv3/1VNh6R+k06uvtt/o/haqK5JKiPa0CDvDJ5BAL4OnClsrz5WvyH5bAdNxYS+9SOoc67lhLmqqvJgbZ64r6CYWAbo8sJDdbx0NOZ9EyyvYQNFnHYlKJUZJpXuE8rwgZbA2t7mB8ihTAH6KsChLFpPJGzMp5Gd6pvCGiZ7iGoZ42G0hYzEdyCcbylCWmRVwWMdbJ7WjAGfkg1Fj5so5AtyRKIYdye5nHzxTjYWrWG811VzXuQre7SwiXZn+AdWe+oH3+5Q5ww7+fT+ShKdI63NSMBeUmLhn+tXdaZu6VUiMO3CCy7NlUHyaEl0lz1Wp9M5SpbTeJUP3Xj6TbTVzY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73500a3-e1e1-4417-43ba-08d75852acd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 07:20:40.5149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyE0qqZ7/aIMkNZ+H0SmYkpIE/b+23PX5D76TUYisyQ8iYYEcBIxAffV5IxkoARcn1+zJwvpmI4sY1zovuNPq5H0oxJkMLeG5U+02bUdjMN1i8+9/KfafUQJjCx2TE1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4799
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQo+IEZyb206IFV3ZSBLbGVpbmUtS29uaWcsIFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDI0LCAyMDE5IDQ6MTQgUE0NCj4gDQo+IFdoZW4gLmFwcGx5IGlzIGNhbGxlZCB3aXRoIHN0
YXRlLT5kdXR5X2N5Y2xlID0gMCB0aGUgZHV0eV9ucyBwYXJhbWV0ZXINCj4gdG8gcmNhcl9wd21f
c2V0X2NvdW50ZXIoKSBpcyAwIHdoaWNoIHJlc3VsdHMgaW4gcGggYmVpbmcgMCBhbmQNCj4gcmNh
cl9wd21fc2V0X2NvdW50ZXIoKSByZXR1cm5pbmcgLUVJTlZBTC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQoN
ClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIQ0KDQpSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1v
ZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpZ
b3NoaWhpcm8gU2hpbW9kYQ0KDQo=
