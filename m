Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C44AFA3F
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Feb 2022 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiBISfm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Feb 2022 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiBISfh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Feb 2022 13:35:37 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F5C05CBA9;
        Wed,  9 Feb 2022 10:35:40 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so3436364ooo.13;
        Wed, 09 Feb 2022 10:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RsWfmq0F6wX1G1e+RM/xgkrQK09rJkHkHiAa0GU9Cw=;
        b=i3F1VYAnVnrlJSdKC53s3ltKr54Mi6fmRw/oeG8ndk1u6uMR/1ISAyp8hXKu4EXKTu
         rO197/EHfhPKWG7nsRr6j/EGL844ZeDgNXHmcPo6kEWyPEloaXx6FGhMuvkyGiqzxCg6
         nw2QN61UYsI5c2tehMLQrFgYMXsAUodycFS0RzP/L163WV1DaVo1srzjG2yrhFI+nE6x
         zo+C/LB73hqx18Zosx10pHuihWiFbvso2G7zDI7ITkV8pYfs5GmiM8/42uyTtJGkUuVl
         dd1sZ86hhjni78i61bT888lFUkstVvvH1ZrR/pvq4QkfauIyVt+jbXIrLlhrL3uZh6gU
         nrbQ==
X-Gm-Message-State: AOAM531WQj1NSL8lZkvCdTdJ9NMRJFyEC3YKnblr8BIFRkAaayZqFzJC
        10TtvaI8Pq4v/9i+RSTDlg==
X-Google-Smtp-Source: ABdhPJz4vuvJMQycGpuhKo8F5FyYxYz+DXI3An7uVJ0o3p4z4D1w0b7P9DinkaIMcDzez15Qjv8kQQ==
X-Received: by 2002:a05:6870:b1d1:: with SMTP id x17mr1416431oak.158.1644431739832;
        Wed, 09 Feb 2022 10:35:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z4sm6826911ota.7.2022.02.09.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:35:38 -0800 (PST)
Received: (nullmailer pid 659221 invoked by uid 1000);
        Wed, 09 Feb 2022 18:35:37 -0000
Date:   Wed, 9 Feb 2022 12:35:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     linux-pwm@vger.kernel.org, post@lespocky.de,
        linux-leds@vger.kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, thierry.reding@gmail.com, pavel@ucw.cz,
        u.kleine-koenig@pengutronix.de,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH v6 1/3] dt-bindings: leds: Optional multi-led unit address
Message-ID: <YgQJeXKnQrWjjzcI@robh.at.kernel.org>
References: <20220208191236.660172-1-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208191236.660172-1-sven@svenschwermer.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 08 Feb 2022 20:12:34 +0100, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> The unit address does not make sense in all cases the multi-led node is
> used, e.g. for the upcoming PWM multi-color LED driver.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> 
> Notes:
>     Added in v6
> 
>  .../devicetree/bindings/leds/leds-class-multicolor.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
