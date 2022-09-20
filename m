Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8EC5BE8AA
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiITOVJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiITOUv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 10:20:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B796610E;
        Tue, 20 Sep 2022 07:18:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11so3209385pjv.4;
        Tue, 20 Sep 2022 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ZNo6njl9VQzi89Lfql6SNWwRdDKHkzKe/5QWx44jgTI=;
        b=INAEsoofZE4tAT5+oEwyD0R+qetq/94sqRsZG+P0PsZhEkakelBLi3ut7Zq9UE+vzE
         NPMuaN1TqTLC+Vh5Q1mr14dSeMkiXNevOesrPj+r1+5ea+2P3EDYIn+9olM+aoDnQNqb
         0O6+qGnSaY1mBPI0dkZ/V14X7jSX12XyIu1zCs6OkE+a4XXj3wkKC9H3n8tCG8I81KB4
         +sBR+ybaYhuXZ6kwnMpW5SPWbrp8C84rcHDI31DsrwKVYuFSs5JI0hBlffckTbiT0ecI
         Xdgv+EKIiobsM89tuRkbTJNuku7kibitERu/5IF7hWmkSWztH3JQ0Xgo69mkR7uTxnbx
         CTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZNo6njl9VQzi89Lfql6SNWwRdDKHkzKe/5QWx44jgTI=;
        b=Y35xhcVztLSzDH9noOE6pwwrznWDxmXXtavfqszg44qy2ShiOK/d9Kkd5cNLgZ60Gg
         DlMn783ng7yylEdeao1y8/JuzDeRNDXVP15uWr7mYcVMfArhdOgEo3qYG5sWO0GVC/yv
         exDOe9KlHK6tNaSf2nqFWBOkt5AAtRTYaOgncGfxwZFyYCjlabR1FtTBO7hncOZ2GVpi
         ahDvk0avmyTawJ6ZTgbNIxyIRYSrbNwcoMmoA+7M9peOG5CEE2bIbHz+rGcE8KdIhw78
         wmFOz2siVmOO8BJRJeIdGrT5r47dvfjDjvfiaujus+L1KCaWpHfl0rT4ONoi2AOkQn45
         SBPQ==
X-Gm-Message-State: ACrzQf3ibR3MRORbwpP+Vpx/1QyiGWbzbtwRFv6E9ZlDG3/zFZmfkYNE
        aVf5rnlzDKGoYzuyZDuQmiw=
X-Google-Smtp-Source: AMsMyM4QODw5yAotYsr55q6C/CJCiFbhAQaNtB5H19BovgqPnNwYvj410xPFXiv6uQIrcAibu1G9zg==
X-Received: by 2002:a17:90b:3b90:b0:202:80ac:467c with SMTP id pc16-20020a17090b3b9000b0020280ac467cmr4056175pjb.17.1663683504636;
        Tue, 20 Sep 2022 07:18:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090b079800b00202d1745014sm89899pjz.31.2022.09.20.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:18:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 07:18:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v5 3/5] hwmon: pwm-fan: Add dedicated power switch
 function
Message-ID: <20220920141823.GA3650215@roeck-us.net>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
 <20220914153137.613982-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153137.613982-4-alexander.stein@ew.tq-group.com>
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

On Wed, Sep 14, 2022 at 05:31:35PM +0200, Alexander Stein wrote:
> This handles enabling/disabling the regulator in a single function, while
> keeping the enables/disabled balanced. This is a preparation when
> regulator is switched from different code paths.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied to hwmon-next.

Thanks,
Guenter
