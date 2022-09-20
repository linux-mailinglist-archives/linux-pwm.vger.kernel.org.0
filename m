Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0935BE8A4
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiITOU3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiITOTi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 10:19:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E7B68;
        Tue, 20 Sep 2022 07:17:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2595381pjm.5;
        Tue, 20 Sep 2022 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=pCNG4ciPJ9yh5kNxzfQwH8FBuF/n5gwjpHd12d+KHyI=;
        b=UJ4hfKllHsFNEvpLzPOL8Ym+5h4RF07RkdoDNwgpOikCly0Ck+99y7hjK40iyEcw6E
         zPa/t1HNKz940oJpdAh8YodGBSWxB3RKcjJKV9j5h2P65UCSJYC9g+nSjzXk+uScyCpP
         EK58hHkGsMIvPnepgVu5z+3FFqZQ9gd0WcyNehvPKAkyqDmfVQAlZzVLzbMWzFbxAbWU
         kbZSp4NuxkYkKlW5YN9paJAMTRb+sWAiMBBkP4neJr9CiqbxN648kuP8c2yBINrSST/A
         7XRpgCeBZB4XI43FIV4V/JW0AUTjb+XjMaL7nwYo8lB8L5K8AEnsfQ/jCucIQNFnLUx2
         Nx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pCNG4ciPJ9yh5kNxzfQwH8FBuF/n5gwjpHd12d+KHyI=;
        b=cdKOII0JvdLCxXsbVvDwC583BJI9L/26nOO4U7IRGvE2GdhaEVYDf6usAD+WnTSTYr
         5UNWnS0co8tPMF1Q8i9BWZe0MvVCzUXLOcwXmOkCj3Wkd6f+gj8KemfT4+VxQhocE+Nz
         CruPhIXKqPv9xef1TyUlRwSwRmmghb584hSz9yIayZDdxpMY4e4GMSGICnd7hXZW3nZd
         8aS15FuIxGXx2fG6snuVAMRFrFbSYL8lbfSfs3H8xbyuX7ulHo1NkMsWGnBKTrNffgao
         vsDM/iPJkzMIIOupjdZmxOjzQ/IGXfgE8R6Ec/WFBB46+hMSQU3M7xTN+Y+aNsXz32VX
         5Hkg==
X-Gm-Message-State: ACrzQf3TJnqDkNtMlWYEZ6eoOW7fy7CabLBtiBkhaB7dn2L2FkWvgmFF
        WfJdUo8T3qf8OW9oStKvCjM=
X-Google-Smtp-Source: AMsMyM74ViFSS1entBqn4NA17FxOT6aR4opisaLMAgl96D2uFqoJeLS9YYSQCK1lvjGSKyTaPFjpfA==
X-Received: by 2002:a17:902:b182:b0:178:8977:4013 with SMTP id s2-20020a170902b18200b0017889774013mr4918520plr.27.1663683438367;
        Tue, 20 Sep 2022 07:17:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y187-20020a62cec4000000b0053e56165f42sm1808676pfg.146.2022.09.20.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:17:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 07:17:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v5 2/5] hwmon: pwm-fan: Simplify enable/disable check
Message-ID: <20220920141716.GA3608857@roeck-us.net>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
 <20220914153137.613982-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153137.613982-3-alexander.stein@ew.tq-group.com>
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

On Wed, Sep 14, 2022 at 05:31:34PM +0200, Alexander Stein wrote:
> Instead of comparing the current to the new pwm duty to decide whether to
> enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
> case. This is a preparation to enable/disable the regulator dynamically.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied to hwmon-next

Thanks,
Guenter
