Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A27597FC
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGSOSV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGSOSI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 10:18:08 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619AC5
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 07:17:44 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 42683A4E;
        Wed, 19 Jul 2023 16:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689776262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYk2sTrBNgJ4mPj7E9x+uunobsKpRUn4I/X+IEzdWTA=;
        b=nUjy4/lZNmWGKFOiTsJ/N7M3+Lq0x5AusjN1U7adtaAmfVVBrSxUAprcvEpESji5jcEOAr
        rRxZfOpVSN9sEGtG6cwVtf+wgBIciVVk91N3n78FvEgDMqgvdOvVc1TPxqpfjfGnCdOQmZ
        RgMaKANDr/mK02Nae9hx3EtkH3bHob5hbryAlTFWBXxTKBjETg58zEbfTSljDBa8Eurkc2
        YPbjEXmL627PTZ3OE4DLSq/LBPrnQALHllMFI1q590iAnQ3Ko81C02ehzn6RTjOVfGGcv7
        9/Yr75wBoA9ju7o+XykxWsc5pfL47ZVAW1UTJwqDxb4ptczOhQpGWO6rcBFBVA==
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:17:41 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 09/10] pwm: sl28cpld: Consistenly name pwm_chip variables
 "chip"
In-Reply-To: <20230714205623.2496590-10-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-10-u.kleine-koenig@pengutronix.de>
Message-ID: <bc30d8483cb3eb901feb986ca88a02b9@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Am 2023-07-14 22:56, schrieb Uwe Kleine-König:
> Nearly all pwm drivers use the name "chip" for the member in the driver
> struct pointing to the pwm_chip. Also all local variables and function
> parameters with this type use this name. Rename the struct pwm_chip
> member accordingly for consistency.
> 
> Also rename the parameter of the macro sl28cpld_pwm_from_chip to 
> "chip".
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> ---

> -#define sl28cpld_pwm_from_chip(_chip) \
> -	container_of(_chip, struct sl28cpld_pwm, pwm_chip)
> +#define sl28cpld_pwm_from_chip(chip) \
> +	container_of(chip, struct sl28cpld_pwm, chip)

This looks strange now. Before only the the first parameter of
container_of() is a parameter of the macro. After the change
it's the first and the last. I.e. the name of the member
comes from the argument of the macro.

Was that intended? Looks like it happens to work because
everything is named "chip", but nevertheless it doesn't look
correct to me.

I'd expect it to be:
#define sl28cpld_pwm_from_chip(_chip) \
	container_of(_chip, struct sl28cpld_pwm, chip)

-michael
