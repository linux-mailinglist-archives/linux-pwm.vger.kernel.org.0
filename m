Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB54768FC8
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGaIOa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGaIOD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 04:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265813A8F
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jul 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690791028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsHzc5Afx1z/5KjDEZBNQHniASDdnavGgK/qk3C3lP0=;
        b=OaJMxhGl4Fc7Da6/zL4h+x20rnzf1n8IGSTnxAAtqdnp5LL0DDs5EWcIhqxqWn8ogmrq26
        YdED5ecVHSJ/0Xd+tjuXX4WxX7Rb8CvHFpMqbrr7c4zF5nCgku0yXnng0JDTpVT8GF5WF9
        YiP3BXHG0GuIovXk/i6IpMdDr6Aa408=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-GqCbE1pnNJSnvZcdW3MI2w-1; Mon, 31 Jul 2023 04:10:26 -0400
X-MC-Unique: GqCbE1pnNJSnvZcdW3MI2w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso26517435e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 31 Jul 2023 01:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791025; x=1691395825;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsHzc5Afx1z/5KjDEZBNQHniASDdnavGgK/qk3C3lP0=;
        b=ciNrnAyRPv8xJuHQ1jjpuKUzg+e28e3eBWxg7t/G15KBl/DsZJDqNnywZ62S4flSiW
         nW7LqyBdUHa+NG1NkZVdpyDPcfgheMXlWQfRnUV++BKJmF7TjVJN8xOZ2vtQKK5H6BZv
         +CmJbMKRmA3rbIyXQP1pGowZT6IEQYe48Jxqk2Zv8Um6LqgY5CYDyv2v5v7UjUaN53iJ
         +8Q+++2Kwuih4tpizJiaYKAqCmWnRubeo09JRy/vDh+ui/0L4ZdfAvC39sybJDjzcFRP
         1iMNYruP2uLbO5D21o30dH/Lq6rd69n/X+dEAM9ErHsBlxQe6B80OFW6coAJT6v05TwR
         2HLw==
X-Gm-Message-State: ABy/qLaI5uszJJ/snU3LeUMH4zXnb5KScgwF3fxlvEKgIgpFrrKnn048
        hysvsOd+a56HuLPjG0ZD6060OhSuOwf8J1JSi7wafGYT0Yq3SWFg/bKzuZbkY9V4b9W9y7HMOyq
        EJVDNADBkTS+TCAkPiU3A
X-Received: by 2002:a05:600c:21c1:b0:3fe:1b5e:82 with SMTP id x1-20020a05600c21c100b003fe1b5e0082mr2780344wmj.20.1690791025232;
        Mon, 31 Jul 2023 01:10:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6WxCPiuCjMbvYCs3Muyf80T7yG1isIk70DQ2GXEQ5HFv4E9qlsTMMGH0Y/lz+Uk1eIK+VGw==
X-Received: by 2002:a05:600c:21c1:b0:3fe:1b5e:82 with SMTP id x1-20020a05600c21c100b003fe1b5e0082mr2780332wmj.20.1690791024920;
        Mon, 31 Jul 2023 01:10:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003fc0062f0f8sm10824433wmr.9.2023.07.31.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:10:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] drm/ssd130x: clean up some inconsistent indenting
In-Reply-To: <20230731074927.22755-1-jiapeng.chong@linux.alibaba.com>
References: <20230731074927.22755-1-jiapeng.chong@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 10:10:23 +0200
Message-ID: <87pm48wlg0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

Hello Jiapeng,

Thanks for your patch.

> No functional modification involved.
>
> drivers/gpu/drm/solomon/ssd130x.c:715 ssd130x_primary_plane_duplicate_state() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Interesting that checkpatch didn't catch this, even when running with --strict.

Do you know which tool this bot is using to catch these inconsistencies?

> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6034
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

