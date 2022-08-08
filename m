Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0058C48B
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Aug 2022 10:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiHHICs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Aug 2022 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHHICm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Aug 2022 04:02:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87F13D3F
        for <linux-pwm@vger.kernel.org>; Mon,  8 Aug 2022 01:02:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso7009578wma.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Aug 2022 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=vXUJQjP8rIx7XMDcV6JeoOjYhMPphCp5ZaeIbtzf1SU=;
        b=Y8xGQgsL0+8ozA/PboFCLxqEV1ccae13qv1viY0jKcoIRP8LhAwoG7OEDNza2oWBl2
         Vzi4sORm6stH94wkD0YGZJJ+4tR+WWPR7/ssqkdTX1vO5bj7bY8/TJrPSBlTb5i0b4PE
         064/D3Low7IoU+9OB9MjhawakqM3YlN32unnjN4tAfJKbIYrTp6fPkT58vBy82N7J8EU
         8A/PRwqU/8s+gIWqzmlTWXLCgE8ghuIoZ3ZoSnrO6r+UTie1Rkob+du7ki4lUjy1YhQ6
         DLgoe8Go/BN/MdQW+7QC606k1wZphCO/+deXMxuSlGMHA8gk5mfZpyMU4x7QngZm3b4i
         4xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=vXUJQjP8rIx7XMDcV6JeoOjYhMPphCp5ZaeIbtzf1SU=;
        b=pBvQXdXL1o3qGPWO0epJ/tyniQkF8nrTTvX43QtElOofw+e+0mGvA2KdU09EOTu4E7
         71hcbrXQl/+AMXKjMVjZnEUWq8/MSEgu6AXD3PTSy9g0qY4tOZoqePIr9Aue7kdd0DmX
         1ZZFHXg8ZuOyavd9nhD0scIYBfQQy+g15r8G7Y3UD/UyH6MFYRT1xXDdT+Dzyp9SWOPY
         SpOHu38/Cfjd1hsto9oirVc6TqJkKil46X5EVUyHU8Cjd6ddbQMYLo8VvajgVf5+EUNw
         6rSFOoL0QT42QuNbPestXUQCwv15yjy6UPXbKJdIueV50OJdwZwgDGIjmA1tvp5AIrGw
         YpNw==
X-Gm-Message-State: ACgBeo27LIjUHe5XcE4tldlUTMC1XczAOqD+WSx0sFo88VytNw4upTUv
        JJotHznNtsEbs4m6+Voxa0hNHw==
X-Google-Smtp-Source: AA6agR5FmhT0LFUR/NvsFfllLgfYQR/8xQFufjsSQmEx+sGyw8puVUGhAN/bLv3HOPx4dJ3EYWp++g==
X-Received: by 2002:a7b:c417:0:b0:3a5:1639:f2a8 with SMTP id k23-20020a7bc417000000b003a51639f2a8mr10844823wmi.112.1659945760083;
        Mon, 08 Aug 2022 01:02:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j5-20020adfa545000000b002211fc70174sm12049748wrb.99.2022.08.08.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 01:02:39 -0700 (PDT)
Date:   Mon, 8 Aug 2022 09:02:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Lee Jones <lee@kernel.org>
Subject: Re: DesignWare PWM support for device-tree probing
Message-ID: <YvDDHUJdBRSRjbRh@google.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <YvDCwOPLoSdxorhZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvDCwOPLoSdxorhZ@google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 08 Aug 2022, Lee Jones wrote:

> On Fri, 05 Aug 2022, Ben Dooks wrote:
> 
> > This series is tidying up and adding device-tree support for the
> > DesignWare DW-APB-timers block.
> > 
> > Changes:
> > 
> > v3:
> > - change the compatible name
> > - squash down pwm count patch
> > - fixup patch naming
> > 
> > v2:
> > - fix #pwm-cells count to be 3
> > - fix indetation 
> > - merge the two clock patches
> > - add HAS_IOMEM as a config dependency
> 
> Can you use the front-cover option provided by Git please Ben?

git format-patch --cover-letter ...

> It gives you proper formatting and a diff-stat that is very useful.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
