Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119584E3E1B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Mar 2022 13:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiCVMIx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Mar 2022 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiCVMIw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Mar 2022 08:08:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504FB84EC4
        for <linux-pwm@vger.kernel.org>; Tue, 22 Mar 2022 05:07:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so10637238wmr.4
        for <linux-pwm@vger.kernel.org>; Tue, 22 Mar 2022 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e3ViaRO1Rr2sI+l49irYHhSyo75k9Je9Jgyertt2k5E=;
        b=GgC5/8cQ71t5bSlOD9BnaRPBc608es5k4URD9kvqaEkT5DWFsenaaorsTuFWteaFEd
         hpAgAGB6IWCH2dJaavSJ8jFwayIZcsQp1IRPc0iau+6hitpeD+xeFMSCkcUaPvtQGyIw
         AWVLJ3L+lhqEBpo73QXJIPEoxkhP5agkIxkUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3ViaRO1Rr2sI+l49irYHhSyo75k9Je9Jgyertt2k5E=;
        b=cnmr2Y4WDteAhtxDtdeZM+/RK6I1oTMtWsbtRQ3a9V0U5xeWTOH0OVjX4eDnlzq3/E
         0UL2R9M+navAd+mwnB0WISY2+5ey4AgCziucCqE/RMc/DOlZ2tDlmXZ8FzAe5DRZSxJh
         qn6YJe/lkix0lgZ7CQ4D9qPKKglH1MihIZvSXyu6HN5ZRY8BwILSQ9vmebavTyJ3hSDI
         PUo2r6RXIKjqKHpd8WGwYoruf7LZ891+u8NlGiZSaVN0elXP23zahwCnQKSMbbiYnnG7
         LJrs6mkj9r65J48a2bwV2EcH3CtkALahoNjmZC1syyWwzHyT9gui2ybAqi7gD1PNc/kt
         zSxg==
X-Gm-Message-State: AOAM533oIzqv2P7lDnwZHSaITP2bvGcWppfXvXVkmWrTKJjRr/A8G037
        5ld1ZLfN8YxYc+KSJJr9Ml2ElA==
X-Google-Smtp-Source: ABdhPJzzDktpUdftxhms3YkoLwxzADyuJj5fnu5TzuR25YBbuhb6hxkCKVsQ1/mv6cY18+N8sYJWbw==
X-Received: by 2002:a5d:6da9:0:b0:204:16b9:ce7d with SMTP id u9-20020a5d6da9000000b0020416b9ce7dmr6518191wrs.293.1647950842504;
        Tue, 22 Mar 2022 05:07:22 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b0038cb3e1773asm1704764wms.44.2022.03.22.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:07:21 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:07:19 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: add mfd/cros_ec definitions
Message-ID: <Yjm797USkb6nUGXq@google.com>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
 <20220321143222.2523373-2-fabiobaltieri@chromium.org>
 <2942ea7a-3e23-7df1-daff-c266a82682fb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2942ea7a-3e23-7df1-daff-c266a82682fb@kernel.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 21, 2022 at 04:46:49PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 15:32, Fabio Baltieri wrote:
> > Add a dt-bindings include file for cros_ec devicetree definition, define
> > a pair of special purpose PWM channels in it.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  include/dt-bindings/mfd/cros_ec.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 include/dt-bindings/mfd/cros_ec.h
> > 
> > diff --git a/include/dt-bindings/mfd/cros_ec.h b/include/dt-bindings/mfd/cros_ec.h
> > new file mode 100644
> > index 000000000000..e02414eae622
> > --- /dev/null
> > +++ b/include/dt-bindings/mfd/cros_ec.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> Same license as for bindings (GPL-2.0-only OR BSD-2-Clause), unless you
> cannot (is it a derivative work?).

Ack, it's not, will change in v2, thanks!

> 
> 
> Best regards,
> Krzysztof

-- 
Fabio Baltieri
