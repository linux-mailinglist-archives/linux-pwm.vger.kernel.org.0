Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911256BA07D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Mar 2023 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCNUNa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Mar 2023 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCNUNX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Mar 2023 16:13:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5340DF
        for <linux-pwm@vger.kernel.org>; Tue, 14 Mar 2023 13:13:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so15314050edd.5
        for <linux-pwm@vger.kernel.org>; Tue, 14 Mar 2023 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfF6fwnjck3bhnls8IFYDauZUKUbRQs1EOuea+gCMoY=;
        b=FGonTE7MrEBng0ymfjw1CZ8IWnRCYQS1AtHQYa7q9i90KRfOgSTG2BPJKu4JlD1wBu
         tODSCQGSRWg4iDawk5wvG84mW5iuHP1k6ogt4zUS3EKsFCzc01Ks64JGmGNfASMrkTcA
         qfdlwVArBX8fCzBTSsbSY4IohrDfoS+ezNANqjj0GZmhBOIkSnjartU7TvASnDia0kp1
         Pbldqrhw+4XuqVyBpUeg8NHij2yXl3lScKSBIkInj5ClkC+Lee6jzDoRFhrCoOBUX4Ce
         7fjR4ugMIDSetOHcJ2ZuU2IrtyUi3ej1E6zT/DnOq9W2rGXdCCl3kklsvNkRkuTMlMkZ
         EYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfF6fwnjck3bhnls8IFYDauZUKUbRQs1EOuea+gCMoY=;
        b=5Yt9lPmE1XZQo169uwJEWQ97eWlN+D7XzYLGHgccjr3ZoJgPDNV31Zlwa5w4JGi+Sw
         NuO2ZfgB2u34BvQLK1e9Udq2PAC1CIsAl3S3N6g48ESOjaLiBrrgr2eQ8VSGU1Qv2fqr
         YIlbEzoGyacgNI/b8I6QzisHhIQ4vRLY9L9il6Nbwt2SFS6RSoTmqK0sFGUUHQK7zVnp
         DbIh4XlTV/rxnOUdWU6yZoByJ4b/k+bmFF1SLS0Wwh++kENrKlacvqj9E8AZzzyK3Dnb
         CHkdCEWGmcFUO+ObQMJVxUGCWe1uSNr1mL9ytCM+Fmn85TDtzyunWYS/4R02AuOel0hm
         m5sQ==
X-Gm-Message-State: AO0yUKW0gmA8XQ1QsN0kvFXaQND78lvBRS36e10l/M0MNXQx16QlfqmN
        TWSLl9EQ3H1hysCtdwCj1VE=
X-Google-Smtp-Source: AK7set8XuSrK8wcL8DFD17yUF75lwZLc+CDnrELGJXtkqu0YMqyHM3+YxMpDRgST+fx1qcmnGAP5AA==
X-Received: by 2002:a17:906:380d:b0:878:54e3:e3e1 with SMTP id v13-20020a170906380d00b0087854e3e3e1mr3520090ejc.73.1678824792668;
        Tue, 14 Mar 2023 13:13:12 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id c11-20020a50d64b000000b004fa19f5ba99sm1507227edj.79.2023.03.14.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:13:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 25/30] pwm: sun4i: Convert to platform remove callback returning
 void
Date:   Tue, 14 Mar 2023 21:13:11 +0100
Message-ID: <3407592.QJadu78ljV@jernej-laptop>
In-Reply-To: <20230303185445.2112695-26-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
 <20230303185445.2112695-26-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne petek, 03. marec 2023 ob 19:54:40 CET je Uwe Kleine-K=F6nig napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/pwm/pwm-sun4i.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index b973da73e9ab..a8790a8fc53e 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -477,7 +477,7 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
> return ret;
>  }
>=20
> -static int sun4i_pwm_remove(struct platform_device *pdev)
> +static void sun4i_pwm_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *sun4ichip =3D platform_get_drvdata(pdev);
>=20
> @@ -485,8 +485,6 @@ static int sun4i_pwm_remove(struct platform_device
> *pdev)
>=20
>  	clk_disable_unprepare(sun4ichip->bus_clk);
>  	reset_control_assert(sun4ichip->rst);
> -
> -	return 0;
>  }
>=20
>  static struct platform_driver sun4i_pwm_driver =3D {
> @@ -495,7 +493,7 @@ static struct platform_driver sun4i_pwm_driver =3D {
>  		.of_match_table =3D sun4i_pwm_dt_ids,
>  	},
>  	.probe =3D sun4i_pwm_probe,
> -	.remove =3D sun4i_pwm_remove,
> +	.remove_new =3D sun4i_pwm_remove,
>  };
>  module_platform_driver(sun4i_pwm_driver);




