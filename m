Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE056FE218
	for <lists+linux-pwm@lfdr.de>; Wed, 10 May 2023 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjEJQEu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 May 2023 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEJQEr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 May 2023 12:04:47 -0400
X-Greylist: delayed 83466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 09:04:45 PDT
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51827294
        for <linux-pwm@vger.kernel.org>; Wed, 10 May 2023 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Zuc/PKv7BsyYTw5vXjXZ1fRjIXUbnX/cr7+0epdXRww=;
        b=Saz8RKF1M1YXdMlmGVIqkuk1FPuXvxO3dfsdyGN1k2laX6p636AyrfhO/uoGCbFoVUvgtP9b59+kv
         1BadUgz7jkBD1jEF8W6kgH4te9AJLnbWSkEG74Zdsxg4+nPi2bpMe3nUeEFuA/FGEi/xov/kXEPm0m
         H0akPuwlf8WA0NTWfhNFzEFNUicuV5yYsLzoQ2ZTw0Iy3WQSu4jOx39oyrVt4kws6UYWXvQlL6wdAO
         HPc687KY08FaOM74C2BxR+DkXcKU16kD9FH4hIb6o9fRshpkrS+t1O530Yq7b0ad0lgde2bu+HdTy3
         kgMVtxDZEoWu9w4PL2FyDrg8TQw0HSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Zuc/PKv7BsyYTw5vXjXZ1fRjIXUbnX/cr7+0epdXRww=;
        b=vYlFgBJmm67njDAbPDTcXVM7/cVVkBM1o7gKoLKUEN4DM2jZTNDzyMceQlsMPiQw8LGx1sMWLr3GL
         hKg9eY7DQ==
X-HalOne-ID: 3a3e330c-ef4c-11ed-9c7e-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 3a3e330c-ef4c-11ed-9c7e-13111ccb208d;
        Wed, 10 May 2023 16:03:41 +0000 (UTC)
Date:   Wed, 10 May 2023 18:03:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH v2] backlight: lm3630a: turn off both led strings when
 display is blank
Message-ID: <20230510160340.GA1180686@ravnborg.org>
References: <20230510085239.1253896-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085239.1253896-1-mweigand2017@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 10, 2023 at 10:52:39AM +0200, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
> 
> Use backlight_is_blank() to determine if the led strings should be turned
> off in the update_status() functions of both strings.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>

Looks good.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
