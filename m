Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3887D43DD
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2019 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfJKPKQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Oct 2019 11:10:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34696 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfJKPKQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Oct 2019 11:10:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so8264829otp.1;
        Fri, 11 Oct 2019 08:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYqY8ptTKV39xxtFZyc1+8jrTs0a76lcIovZ+BLPMag=;
        b=nQ2DLP/XVGil9naV8d2EwI93UN/S2WvNyxN1AtE2Lhw4aXOOAmgAfEE/qoGjP3wOQf
         Zg6BRloeF7rPCjiIDL+DOqK4+8f11yzdoKXtK45oHqOKl1AZROXJuX/xY9IevTRCk2MW
         Qod2G2SHABfcUdNspksak21n5w6OuRK6yM+KUXMfD1ZkarwP8/oVm7MQtjO7YZROIe6G
         h7A+hKfKeEtetfmnTE/yLov+2PcxpQEcmFK9fMb/uCWjpxmAGpq7w+wKgByF2tCzLrmx
         yM852KfVSn4o3Fmm998CdjqYxqrLDRT0uHxgrvvmBUxLveLg7XmX4qeDL/5gVpMpA0l5
         pRDg==
X-Gm-Message-State: APjAAAX9U0OCtJ+xFrMXf3cbk+aojNdyFvOilm6Lo/sBMkkFU13QwCf5
        E8726rEZ8eSDbP9TQdapBg==
X-Google-Smtp-Source: APXvYqwkpn2Rm6NPxteihd3r7HUcq/7kBVqTZFOHHnjYbh6GQJSC3s6NgoJrW3CK0nueqj8fb335Cg==
X-Received: by 2002:a9d:7345:: with SMTP id l5mr3406363otk.39.1570806615029;
        Fri, 11 Oct 2019 08:10:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k2sm2719648oih.38.2019.10.11.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:10:14 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:10:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        fabrice.gasnier@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, benjamin.gaignard@st.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm-stm32: document pinctrl sleep
 state
Message-ID: <20191011151013.GA12791@bogus>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 4 Oct 2019 14:53:51 +0200, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state that can be used by
> STM32 timers PWM.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
