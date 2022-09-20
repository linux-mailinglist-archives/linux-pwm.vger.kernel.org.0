Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44C5BE8B3
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 16:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiITOWb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiITOWL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 10:22:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD616173F;
        Tue, 20 Sep 2022 07:20:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so5498116pjo.2;
        Tue, 20 Sep 2022 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=MM2OwehSD4w+SRcjCT9w/d1MVH2cqxHEdeizOfYKXRo=;
        b=Ce7WXK05327bbx7pVwuiwGHyJlz3zC/Bw/fMyFdMwGkhQzNAdklClTq6Wo6lyZnFAf
         dMWQrZJlkx+YuxbP54/bZpZsPoh+3Wut7oUs010+9FfjSuaz0KfOJ3dL+cDOV0eYNal1
         wdT5j3j6OGaBUFVF4cnClkM55Bo92qWe98+LArjwgMgcCmhmo4asOfLWcHNlKYslz3E+
         pPFQPExTlTYX3wDgVgh2En9oiGBXYJSwKmgRaPaoqbIX83XJ8q1W6g7b6Gvb/WtDuybX
         jgp+g04TRFF86AwGsqzklEYdE51mE7vEgOsxZ43Jqn3c39j83HIaRu+ur4vK4PcDxURl
         RztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MM2OwehSD4w+SRcjCT9w/d1MVH2cqxHEdeizOfYKXRo=;
        b=RaLC7/Ab55PloAG+n3fcvtnEOC0rsZFBUpUyAtevzqrKOMzAo+RJcojmn3H7yjUsg5
         DVnRrE5HMfad3sstLzF1Hbj9ul4WDwIw0p9RXdS05adx+3Q8GWh4sIay4zrzMW7XoumX
         z73l9s6/gbnVACcG8Zvnry5USl2Bpn1SP3ehOY2DT0QB0E4qCVU6wz5/qLC6Ke0/0OvD
         L2CbRyCdg0RNw56Pl9YJzBhAgwfgEpN3/eeg5/Ito0eJJl1UJwE10KWsLgjz0e41PW7w
         3AOLcoLsmwLqZ6dQSECmazg4IuXEBKqsOJfIvad00V65NzjU5pH1ny0UMqtLEsiYQm0h
         3GKw==
X-Gm-Message-State: ACrzQf27PwzVJM8TgAvsVUOKgaiY0zIOlZ4PXFsRY7HmWw0Mhl/1nGIr
        gZLHGvrMUmYoow+ihdTJX44=
X-Google-Smtp-Source: AMsMyM7L0EDeJeW6C7Nba6Eu0RNEClyUTjEc7A5i6XvACgTXfgPaf/T7EzK5QmObl4TYTQTczdWVCw==
X-Received: by 2002:a17:902:6a8a:b0:178:1545:a147 with SMTP id n10-20020a1709026a8a00b001781545a147mr5011207plk.157.1663683626685;
        Tue, 20 Sep 2022 07:20:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b00176dc67df44sm1522552plg.132.2022.09.20.07.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:20:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 07:20:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v5 5/5] hwmon: pwm-fan: Switch regulator dynamically
Message-ID: <20220920142025.GA3718760@roeck-us.net>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
 <20220914153137.613982-6-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153137.613982-6-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 14, 2022 at 05:31:37PM +0200, Alexander Stein wrote:
> This adds the enable attribute which is used to select if zero PWM duty
> means to switch off regulator and PWM or to keep them enabled but
> at inactive PWM output level.
> Depending on the select enable mode, turn off the regulator and PWM if
> the PWM duty is zero, or keep them enabled.
> This is especially important for fan using inverted PWM signal polarity.
> Having regulator supplied and PWM disabled, some PWM controllers provide
> the active, rather than inactive signal.
> 
> With this change the shutdown as well as suspend/resume paths require
> modifcations as well.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied to hwmon-next.

Thanks,
Guenter
