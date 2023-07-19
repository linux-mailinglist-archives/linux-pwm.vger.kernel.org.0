Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC847598DF
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGSOzf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjGSOze (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 10:55:34 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715111711
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 07:55:33 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D8AFFA4E;
        Wed, 19 Jul 2023 16:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689778531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BezhgEZ3QJmVt+9N/3+8JtxlC8yi1o/bzbB/y9p854=;
        b=S0oemUShZVYBo3j+OmsIkSWbQf1gMAFfwOEE8uTIo5ZxdxYzQPElZBbGfdUT9aSsBja8WI
        85sh+hVmWwKbDSFY16+qbEYECosDIVyOsDe/543G1EGV8FTEJ6hbIbvV73b7PErV82qyKP
        aOQ9UBP/mlazRMo3wIx00dLruq6gCgaUED8RAWZp8iirbs1zZOFTjPYSufc0QwrhAvy0tA
        Ny40c5+3fx38J3dwvv5Ky5apqoPGnCVjbPbIOqQnXJywE3cUghFLVWLO49qNB4H+zaogaj
        JUmciCObGNc8t3B1fQPnkhpX+FhopVbCXqUaiDBYFgVgXnJDUTh8QMe5U2Ao/Q==
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:55:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 09/10] pwm: sl28cpld: Consistenly name pwm_chip variables
 "chip"
In-Reply-To: <20230719143956.6sv3feiroiwrcosb@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-10-u.kleine-koenig@pengutronix.de>
 <bc30d8483cb3eb901feb986ca88a02b9@walle.cc>
 <20230719143956.6sv3feiroiwrcosb@pengutronix.de>
Message-ID: <9cb1b141e206dd9afd215d8886d688d9@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

>> I'd expect it to be:
>> #define sl28cpld_pwm_from_chip(_chip) \
>> 	container_of(_chip, struct sl28cpld_pwm, chip)
> 
> Indeed, that's bogus. My preference would be to make this a static
> inline, i.e.
> 
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> index 98b0024f9658..c789e934671e 100644
> --- a/drivers/pwm/pwm-sl28cpld.c
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -84,8 +84,11 @@ struct sl28cpld_pwm {
>  	struct regmap *regmap;
>  	u32 offset;
>  };
> -#define sl28cpld_pwm_from_chip(chip) \
> -	container_of(chip, struct sl28cpld_pwm, chip)
> +
> +static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct 
> pwm_chip *chip)
> +{
> +	return container_of(chip, struct sl28cpld_pwm, chip);
> +}
> 
>  static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
>  				  struct pwm_device *pwm,
> 
> but I can live with _chip, too.

I don't have a strong preference. Looks like most drivers use
the inline. Go with that :)

-michael
