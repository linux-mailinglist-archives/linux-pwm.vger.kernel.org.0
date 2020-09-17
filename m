Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3126D3C3
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Sep 2020 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQGho (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 02:37:44 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:36993
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbgIQGhn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Sep 2020 02:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enIRquX0Zgpv8qAPGRy+ny/OXpGryrEwMEOhfva7N5ToxCb5Wh8J/0rVsMm8P82DOs9yfkqFhi6woUH1OJ/+G5e3+M0HOnI/6/Y9kW9sqQnXJuS+VV9OwiI/FnEZYvLW9EQv6VTBNS7z3xkX4ExhfuDH4QkREPZJh7GazZimpCo6g5LKR+83freRXAfooelVo3xd9ENpZWsCkAYZSCk0Vxu/8vDv7fLFp3irC5IvUo0/CATdTCSeecreoJDQMARJKQVhVF+EG123vWWL1QBz2IsV6FPqvex8QmfiwM0/eD4Fm6iqXTkWwRinRlCGgza59UDy7qfZlpSmHGL0FpQYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSZwACkWH4U6TlTGhRyGDN3sZlhs25HMsloGKq+Ki1Q=;
 b=khlgK35BHoG/BlPCjckDBs024bWHN+yqmeTEKfQZMU1djWJMYPr3S/RIu8FHtQIsj9aYag6gVIevu0W48Nth1b8pGENPYpjLLNuWuu1AgmWzzbef2t/RJUUntvmD6U+pcno13T5wXsNQxmjyQp2LCubvYOrvnNPTV6C4rG92IoDycKNIZd3Ko3juDns/W0te99MDl8t+0pAVvB1VA8RHLI6hUBNFGydzzRUZ0fFGz12CrXbHfB05ncKDnJLUaWzXn11qIbkBmPkrYGupXfGSEkRlVRatvsPCMUooytXooe7WE7gHDSsNElUmKQXEJxm9BZo4Xuu55OnxyoYsXw9KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSZwACkWH4U6TlTGhRyGDN3sZlhs25HMsloGKq+Ki1Q=;
 b=j78p3DYQnhDYpMatrclbC3V/yEQOhL5qR6IeO66mBiX/XSauhaw6CWEoshilmEb+XduVVOM/Fi5kNPRTKgYO+EhDCM3pYu5XtYDFwa4IT5V0+rn8/BE5LwCQujwCGW+8T74B9tspYtqGhw5+nbiIQxBB5RUfRvcSGrxhgxCgPNY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DBAPR04MB7350.eurprd04.prod.outlook.com (2603:10a6:10:1a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 06:37:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::9c75:8bb2:aff6:450d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::9c75:8bb2:aff6:450d%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 06:37:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Thread-Topic: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Thread-Index: AQHWb6jFmW826APPQE2tjObLx/xFGalsmpqg
Date:   Thu, 17 Sep 2020 06:37:39 +0000
Message-ID: <DB3PR0402MB391689D2F31A63C720291456F53E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7249c09f-5321-4ab9-e66f-08d85ad42c87
x-ms-traffictypediagnostic: DBAPR04MB7350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB7350DD57408A2496EA200F2AF53E0@DBAPR04MB7350.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j18LOxkDHhHtcu+aLMc9eBowk+WT1Xdy1k6No9cZ2hl5h/W+pqCdUCATfpHm66kemnR7iAIlurI8d3Z82hWvZz7/RPhgO+L1geIDQ/6Rh1QUQNUV69iEIz94Vs7am93FpXzefy4FMjxKdD/RIuXrDfY1k5vURq9uXvehp800ZVn9202RoonASLOMP5T6ambHEPHK/UJl8icTFhi3ZCF72Soxzs7vom5OHwnENSUY6R29crHtRRnt9fOFWEFQ7cCXdoXUnVYyG8L+K0ExJv9HmdZ2uTUBCBVKZ3KMb5PZSwp0eXUEm4EImU6lAeE2oFK+9p4/klhX13Z0dFeOQ55RuTSrDsw89gmLms1yKt7HxS+afIW0+FKQnaC69d8PbzXw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(52536014)(186003)(6506007)(7696005)(478600001)(44832011)(26005)(7416002)(2906002)(316002)(55016002)(8676002)(4326008)(9686003)(64756008)(8936002)(66946007)(66556008)(66476007)(76116006)(110136005)(5660300002)(83380400001)(71200400001)(86362001)(33656002)(66446008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KW4VoDkE1Tcl0lsNago8cFeXJ+IwS5yrsxGYWJE8yugbD0Z0qxV4Fco2m/ZOpfaq8Z3lGXhy1jqEJ+U/3xVJ840RpW75qEqk7L9avQgqdeDfvZazy1x8Cgv9jAAEZj8WT2Pzpq2PNB3TFDb5UAwsdkXcgH7/2fjssKcttwtIly9lWP53hOjGmey+4V1lGyOHo5vkXbufL9hnMK5Jf8CRBNbHX+UmcO9Kd6j55W3+e85ysdvSAtEPa0KoHCfnxy+k6W3VQkIcNg3OwTRZyD7z6iSHQt7c+UliWd30keOaU9hWhnZRIb7l16dIetLW5ShXklJeWi/sTPzhRXuKInpSibs2c4kL84KDyKTf+lIiqXZb5vVOnHi+7bYDZOkLrakLKB8h8vsYLazAbaNpk0iPBS3/usFgOkJ26brVQpTcXQeC34xBfetYf+kV3VkOSiL/A6rXFjpOsKucauxapb9mfErsTSo+gTGhNsMkCewEhMjoWqm4JTvegqBKI8A4GXf4PwVAAHnQil+4rn4ri6yDHfjVDPt44XDzIEX0+dz18KFXl2W4B9I+Wu1v2F28t2kvG3ynhdQ4ttafGqzP7Rp+t8b/OFiP5m4GJwrtH4GZrsRQRIK7UAGOv3HJsCoO8sYsOIxMIBGeT7sTbP57bgHnUQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7249c09f-5321-4ab9-e66f-08d85ad42c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 06:37:39.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOT6znPzm7DSlFLD72uZ5uLpwPmAe+VgxYIQAOHyfAmeDE7XtMMzhKgJMDNnh+0Ck343ZB1zYM2EaUbCYq27xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7350
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Gentle ping...

> Subject: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify err=
or
> handling
>=20
> dev_err_probe() can reduce code size, uniform error handling and record t=
he
> defer probe reason etc., use it to simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx-tpm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c index
> fcdf6be..aaf629b 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -350,13 +350,9 @@ static int pwm_imx_tpm_probe(struct
> platform_device *pdev)
>  		return PTR_ERR(tpm->base);
>=20
>  	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(tpm->clk)) {
> -		ret =3D PTR_ERR(tpm->clk);
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> -				"failed to get PWM clock: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(tpm->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
> +				     "failed to get PWM clock\n");
>=20
>  	ret =3D clk_prepare_enable(tpm->clk);
>  	if (ret) {
> --
> 2.7.4

