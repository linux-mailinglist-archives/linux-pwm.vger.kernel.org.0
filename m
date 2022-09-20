Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12105BE887
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiITOTT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiITOSa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 10:18:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908F647D0;
        Tue, 20 Sep 2022 07:15:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w20so2492425ply.12;
        Tue, 20 Sep 2022 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=wAUVDvOn4nidMcw5qCBphiOGFREBgCsxMqMTM5qoZxQ=;
        b=nfiZjxRpXgX9XwG2E1wZB8SdRgSmB9zaztsn6lneuPU8chlnnMnShplrBtJtMUzHfk
         omN8tHEbi0e90FvNVQDeFtbL0VTUysb8TY0VBwZLXmi4mkUClmaZVNUgw3Dtih1KqvPh
         NvvdT3ALwEm9OJrqK3gwFmHodETqfXlUA/82Hlc7wQgmMn/DBSGsXl8NdDu+KQfvyNyL
         8XSMRMVbV1NcFlJL1pWSxQWYOTmjysLqOux+3jPUq1ZVLq6exMnpq0n6H50ciuPRbClB
         xVpoF5YeFOABIYYOJ/EJlRV66oEQbrxXHt1NEq3lGicTm+qMkMgiNBP9SlJLpYv80Zan
         hf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wAUVDvOn4nidMcw5qCBphiOGFREBgCsxMqMTM5qoZxQ=;
        b=YPrlfVpZEOAMACqXgl7K2UN6zmfDGs7d31yu3ZdTyqspXh+igJE2pg4vBfcbHZv0n4
         +AydQGdvSQlc5dhaY+GVjLNeQLZ2ChAUV06BUshVmFZIdpkk7M+GqS5jzx4TV7lv/QpS
         UJLsVGAbg877+o7Y/XZ9g9HBlOcqBUlWUQmxIY4eQsWcIhnA9XgCYoHPkBptw/Td9FY3
         uW1YrhKAvaYxDemKXY/C+qkfA5LOt+DxARf9erJ/1kR/kpSmaedklzdijrzZD4iZ21iq
         /KvWEDL54BdD2XRVnSV+IxxYAh4n189lrAnxiZegCL6p/6H6GJDIuVr9eFN7J8PRTCzk
         7D4A==
X-Gm-Message-State: ACrzQf3rBpigKBP8bfxdrHMFo628Tiz8RiZgo9x3cpfu+tvs2QwfHPZs
        ahOLEK1sKo8EZicH9vQNzyI5cfxr3EG0Mg==
X-Google-Smtp-Source: AMsMyM68b0WtLpPc/w83eDGvFpZzvH/nxqEARMqYCQFkJqUQLTGiuq/Q59W++2VBifarmDdzX1P0uA==
X-Received: by 2002:a17:90b:1bc2:b0:200:a97b:4ae5 with SMTP id oa2-20020a17090b1bc200b00200a97b4ae5mr4269356pjb.147.1663683348913;
        Tue, 20 Sep 2022 07:15:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i131-20020a628789000000b0054d525414e5sm1766127pfe.117.2022.09.20.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:15:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Sep 2022 07:15:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v5 1/5] hwmon: pwm-fan: Refactor fan power on/off
Message-ID: <20220920141547.GA3562059@roeck-us.net>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
 <20220914153137.613982-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914153137.613982-2-alexander.stein@ew.tq-group.com>
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

On Wed, Sep 14, 2022 at 05:31:33PM +0200, Alexander Stein wrote:
> In preparation for dynamically switching regulator, split the power on
> and power off sequence into separate functions.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter
