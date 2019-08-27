Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3849F000
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2019 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH0QUU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Aug 2019 12:20:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44641 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfH0QUU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Aug 2019 12:20:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so19188436ote.11;
        Tue, 27 Aug 2019 09:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03y+6O+pVdA0iRm3AU9FQ8YTQS7jTiqNnHaIUG6Eo4I=;
        b=Sw9/jXIoAqZpm2F0NqDym0bH1i070k6y8tAwOnStGwKSeDsC+lPtbPiDSfoqykrTnp
         zak37mpWTWkJgSw3FfjrmluMeOXjKQbZRkHEr8cttH8QiLZWb4RFpRGd6qFNFfPpiycH
         orVlFTDq5Fsh6TAe9+nbumon1sudw5DNv2CR+7sfW7jn87ji1AmyWl2F/tB5USuNM9ma
         QwD8ntE3P70+wf7qj3ksemT3w2vcBbUPGbGzKHbCZ8JcrObOeJkqz/IwUB5plTwS5E4r
         WPqUj4joBSWP+75A3hODaPQybF704ltqFOERwGXA9A6hJXRQ+ubt1KdEEks7DVnx91O8
         k+Yw==
X-Gm-Message-State: APjAAAXCKCh4fRR200sJWDjG6reTC2yGsZ8rQ1zXArnTy2LlyLo7HN6L
        x+3m3s+PgsXV4pB6N8F1q/t8nVg=
X-Google-Smtp-Source: APXvYqy6L2w6poPxiOiA1JXS3qP3upveE43AeK0ekRiMmhT+yWG4TzGjK2lym2Xula+v5WXsCL41wQ==
X-Received: by 2002:a9d:77cc:: with SMTP id w12mr13373051otl.207.1566922819429;
        Tue, 27 Aug 2019 09:20:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f60sm5991174otf.18.2019.08.27.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:20:18 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:20:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Message-ID: <20190827162018.GA11135@bogus>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 14 Aug 2019 20:46:10 +0800, Baolin Wang wrote:
> Add Spreadtrum PWM controller documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Fix some typos.
>  - Move assigned-clocks to be optional.
> 
> Changes from v1:
>  - Use assigned-clock-parents and assigned-clocks to set PWM clock parent.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
