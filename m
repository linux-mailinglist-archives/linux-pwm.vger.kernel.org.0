Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01C575BEB5
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jul 2023 08:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGUGUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jul 2023 02:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGUGUH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2023 02:20:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC849E8;
        Thu, 20 Jul 2023 23:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA2ysNGZYRE630HgS31XP5uuFRnwsKtR5+eR6xJzVYRQfC19TAzKbOZu+ASDpfMHXbEPiiywtCYHhb8tnRprb73Uiag6GAzPN8gZLnbC39Ij/IxTyo6MDDtLJ1yCVTrX03UUWsO8xgPcogi5tqlIGGbzj/ydc0bp5l6vqsQr+QpyS6NZdVd1m13YNXxEyD4lIzs9UvDjHgo6vObO3YWOYfrSdHV0tWTwb8/7tx5Hw8xLKQ+UDhV+8KaUBqUeSbFIGXKDq3bW+Bmr8RGKS1P/mb2Cr/QAaKBfrPegAglkZVi+3dPSRPzitbbaCobSRaoueuKyVVqqOvZJFbaIkTiBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHbmMYeAS3nE9m4SYtG8HAf6L9WV37f1hW3vPDcXWho=;
 b=kBT4592zoKTRcoafPLjp23dxfODOgMuTzhg229mGQ1lFTmLTf6vjG+uDYM7i8v11ZbYod3gOGAhTq3gxGMlEcw354S1Ghi/eASbufeQKPnvhgr6oS1LYlDUvL6SpgvmXCajGt/o0Gfm/JP0QyTFmHFlrj+mDVhZIspHNO8kPwEsnLDBQbdk53Ppcnr5FLGlaP57RYkHX4ETVgyJIO5yvVxYUAIauEUIUf18DAsEwWK7f4OY2rJ/sL8qtxoykk1IVd9AvKoqCghqGC94mqmcJXOuzK7kNjXtDLEpWBXETrOAXraKmHYzBPa2T51TBXjfEUWj4v+mn4y2oUvdsOaROZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHbmMYeAS3nE9m4SYtG8HAf6L9WV37f1hW3vPDcXWho=;
 b=phCu0hxKd+bYN5HpKJISzdSWesbrAo5BBEVf+W2NgruqgcatDqaPwbZ88Y7VbewH8eVJp5HUCWrFD2CJY03mAVbqpVUh/Liwsk8AgnLbnT06PlvP4sTt1FJwoaZ3Txa4EKIdqsBg1iupsm0UxGgpnGxTHm4bmCYXyZaWvofU304=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6157.jpnprd01.prod.outlook.com (2603:1096:400:60::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 06:16:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 06:16:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: RE: [PATCH] mfd: rz-mtu3: Fix COMPILE_TEST build issue
Thread-Topic: [PATCH] mfd: rz-mtu3: Fix COMPILE_TEST build issue
Thread-Index: AQHZuX2M1+FvP+cMGUSnu/dwZ2FtPa/DwhGw
Date:   Fri, 21 Jul 2023 06:16:44 +0000
Message-ID: <OS0PR01MB59225B70A8D41B87116096C0863FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230718134119.118018-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230718134119.118018-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6157:EE_
x-ms-office365-filtering-correlation-id: 630effe6-e4ba-4dfb-6643-08db89b20e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZU0DpIe0TUJ84R9BSbZcX6CPBu3fzgdUYaunRpchCZ2MR3JPom9yFE3roI71n1i28G7/v23saJ1sOWKUkgMhg+dLhEFqEKub3HhdbcXvL6l3SC2MLEoOxSTl5APpSR6b4UkxW0prRB14qwx1WF4n9331SwoTKHPr9O/Wip74kNJUdFMTr0jdoLoRDQYA3pkz61aneBCq2EfJq8ggBWEQhJVXy5yQvF2/JmrH2UL/7dMP34Hl7NsagoRK06RzLuQpimqWsHH687ViStdfk2r0rQtgMaziplyw4/UZkm+02wvcG6bbWhwZDRb2xdXUsZL0MOackvVkarzLAC9wczqv+s1pc/O72g/fUrtL/j99BuJ5C2oI/Ws3ifw4NfIiUfzpIs+2RXH+lZefTJjrdTFuEMkUgf8wDoPqWDmjOixgAYl1XACtoQPMGYgW9XFx7BoDbYAiVBWbFcqvhXJ9ZCav+2KWZZpVhTtIG48xV1wcYqYtAs/MiEEtHq+FwgceQjnYM6OjcOQ3WKIb29OdAURGyNw/9e3PkRmurNawYTVkFNLDfu0mqQV5Pqe3u2eeYItUkb9qJpQ729JY9wsTpxPgAvvZC6vzZrc6pNaGw3v5T8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(316002)(66574015)(64756008)(4326008)(86362001)(2906002)(52536014)(38100700002)(38070700005)(5660300002)(8676002)(122000001)(8936002)(83380400001)(54906003)(66556008)(110136005)(7696005)(966005)(9686003)(45080400002)(66446008)(41300700001)(53546011)(6506007)(26005)(478600001)(33656002)(55016003)(66476007)(71200400001)(186003)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ubiamJUsV6hcA+sEk04lcBwA7YNgRZtjP4FA3Wi042c/cHuZUVvsamm1Xs?=
 =?iso-8859-1?Q?SL6DUGbLlbEUTFJ9Bp0vrEXRS+ytqWd+/Teif+Vlee5FHsmNfNjEMNWEPg?=
 =?iso-8859-1?Q?H21qXOQWEPlM2ixEn6Bl0fDnagzqEfRG1fRO6IKGPM3nQUeNJ5WttMoPgD?=
 =?iso-8859-1?Q?aZP03q9STIJ9tN047Bb0zhVUx1CWmMGDFm9yWn57MtwdfS/qIdV4D9Yiag?=
 =?iso-8859-1?Q?TsEmdUGIrZ3/2iG+SQLY3BOFXsJ79lreq/2AqM9vu/6q2BT8B+TYfeGe1a?=
 =?iso-8859-1?Q?f5MJIbh0GUI4w/Oi9nH4PCqFV/ecDfikw2JowSn19SP7oIAIgEpRRKaiw7?=
 =?iso-8859-1?Q?ot2uFOtwGsm511H3vu12usFcLoHcdCurM7RYEgdj3bbPcU21eRTh2FQjAO?=
 =?iso-8859-1?Q?TiqYtfFRg5ShbQUXkzVidnGM/aF5Pp42TSijk0dLPKcy7zfT6w5FNRr+s4?=
 =?iso-8859-1?Q?N5/WOLUtmHmCcV5ahPaeKId556kGjxOyNOtIPmNu0JJtpbdZ3H2AW5ziMb?=
 =?iso-8859-1?Q?MFbyNpeklpb4xfKwju7cAYHF5XBXQYlI2liOWaQuMFUn2P16Bw9V2cGsI7?=
 =?iso-8859-1?Q?aJDdDhDyZ8hf1jjKQMvv94fcXNZ7lb3nZGTYs/Tu/br3Pny8LE+n/8IbCC?=
 =?iso-8859-1?Q?zzVztPbzWKrBHO+twZZPOX3Sh7aV1mk2FucWY7HDpazbCB+sdIu57FYzmS?=
 =?iso-8859-1?Q?aeZtMTjA1G6V4DofvZEEpTHNyz5gcsC2gsxzTNvancpDogcP5A0LM9gh9k?=
 =?iso-8859-1?Q?6TOqKaeTMk5q8qckUdtZaLFuay+35QUGLcPMH2s7mHNeoP1AWy+8mepnK9?=
 =?iso-8859-1?Q?kN1yg3Kn2sdIC6nqlIS+UqqlMSDcYmABBbGIEDoBqS9N/WgtzORalzpB6Y?=
 =?iso-8859-1?Q?eLzizbGAVkGEA6X7myZ8QtvJrS5ZIpvfkqkpQ0pPC05SoUIRaBcyNbIYhv?=
 =?iso-8859-1?Q?woz7rZ3X9xmGqX24zSaonVV6LabOvidPVyqz2oqGFk0UKPp2ZmEriNkpyj?=
 =?iso-8859-1?Q?WCs4blyceiUj4mZ0RrvZnHoXdNjcBN++T6GDd4iYEDSMhS7RWGtugsd2xI?=
 =?iso-8859-1?Q?9rqGoyTrmCMMX89NIsmsPh4XEcJlBPOjegGsvTK4XcufS+AdQzDQJ6MS5F?=
 =?iso-8859-1?Q?tdiwX5/vsdW9/ni7KXsQ8enZIoGE1/In8658WPNOat+HDajdvkJTFCe6VR?=
 =?iso-8859-1?Q?b7IeikRWCt65MyS7M7ztSkJvSjvtXHP4gOSg+UqaU3RM2yrPF8rqya6PIC?=
 =?iso-8859-1?Q?RCHyBYx5YtpmWBo94vI4FGX8wUi5UprH1WHmRv7cSBuSMLXsnYysfA2Sae?=
 =?iso-8859-1?Q?+75Js8JwggPMhpyZcWReq7CExFSqzSPOkp+v6nqwrDF8KDJCw1JAbB4x3G?=
 =?iso-8859-1?Q?QxoRms5IoSNE5dE1jV1VKBBV25hP22OoFrzbvHojfFqiTmJpM1dmxufqkY?=
 =?iso-8859-1?Q?xktRY4i0alezLweIT4Tw+gEQTkM0dIVflebMECaKuBTqOpaqRaqlFfZPc7?=
 =?iso-8859-1?Q?1o1XUhU+LJWNeUfqjpQ8ajd1oOsIsf8RnmW2OiBsR/MODBS306f97ozaFr?=
 =?iso-8859-1?Q?GklTN0JOpneuTtKquK1HKRMG44hi6ebNq1Gk9X3ic3F6/iXvsOanM5+5Nr?=
 =?iso-8859-1?Q?SaWy/ObV5hzD83TlYlTSb8si2oAzyzUFSc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630effe6-e4ba-4dfb-6643-08db89b20e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 06:16:44.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqXG08FMy6J77maQlbMRrq/E4xP7uFnKrKW4qtY7A9/0yzUI0YbkwxVpkVwCbs9SLNbLxa1QZfjop743yLWBNo/fOSDN2q0BQXPczAofopw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

I would like to drop this patch as better one submitted by Arnd[1].

[1]
https://patchwork.ozlabs.org/project/linux-pwm/patch/20230719090430.1925182=
-1-arnd@kernel.org/

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, July 18, 2023 2:41 PM
> To: Lee Jones <lee@kernel.org>; Thierry Reding
> <thierry.reding@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org; Randy Dunlap
> <rd.dunlab@gmail.com>
> Subject: [PATCH] mfd: rz-mtu3: Fix COMPILE_TEST build issue
>
> When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build erro=
rs:
>
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to
> `rz_mtu3_8bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to
> `rz_mtu3_16bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to
> `rz_mtu3_8bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to
> `rz_mtu3_16bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to
> `rz_mtu3_16bit_ch_write'
> ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to
> `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to
> `rz_mtu3_disable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to
> `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to
> `rz_mtu3_8bit_ch_write'
> ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to
> `rz_mtu3_enable'
> ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to
> `rz_mtu3_is_enabled'
> ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to
> `rz_mtu3_8bit_ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to
> `rz_mtu3_16bit_ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to
> `rz_mtu3_16bit_ch_read'
> ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to
> `rz_mtu3_16bit_ch_read'
> ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to
> `rz_mtu3_8bit_ch_read'
>
> Replace the macro IS_ENABLED->IS_REACHABLE, allowing COMPILE_TEST to be
> built for PWM_RZ_MTU3.
>
> Reported-by: Randy Dunlap <rd.dunlab@gmail.com>
> Closes:
> https://lore.k/
> ernel.org%2Flinux-
> pwm%2FTYWPR01MB877550F95CF000B63E9AD022C238A%40TYWPR01MB8775.jpnprd01.pr
> od.outlook.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7=
C
> fcf81d7f6a964899f30608db8794ae02%7C53d82571da1947e49cb4625a166a4a2a%7C0%
> 7C0%7C638252844861149534%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DQ2K5x=
i
> BSEtwf0cwP98ITkZPGs%2FPKBDxeAgAww7x7VME%3D&reserved=3D0
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  include/linux/mfd/rz-mtu3.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
> index c5173bc06270..4f15c0dead60 100644
> --- a/include/linux/mfd/rz-mtu3.h
> +++ b/include/linux/mfd/rz-mtu3.h
> @@ -151,7 +151,7 @@ struct rz_mtu3 {
>       void *priv_data;
>  };
>
> -#if IS_ENABLED(CONFIG_RZ_MTU3)
> +#if IS_REACHABLE(CONFIG_RZ_MTU3)
>  static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> {
>       mutex_lock(&ch->lock);
> --
> 2.25.1

