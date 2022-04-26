Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919A50FFEE
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Apr 2022 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbiDZOF2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Apr 2022 10:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351388AbiDZOF1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Apr 2022 10:05:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2395D196894
        for <linux-pwm@vger.kernel.org>; Tue, 26 Apr 2022 07:02:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so25595594wrh.11
        for <linux-pwm@vger.kernel.org>; Tue, 26 Apr 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2GTfUc7VLX7J3kb7UZo3L6hgl7G3SCi+Soy09ZT8/Q=;
        b=V16PSVQfUB/Or3B+sTPWN0OESvTLnOXJvVItFoiiWr+i+XWczhhBYVqK0CQKrBFUPV
         2nQrPeuHneJbpozsMrqjc0knwusbWrNPFgRqv28DbmGNIILbFLlzBHm98vIKW6Pp1XT1
         S//6Kt+IKv+px8Q76JYBkx1Hxff3JHR3cKMP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2GTfUc7VLX7J3kb7UZo3L6hgl7G3SCi+Soy09ZT8/Q=;
        b=kGhR7C47eug8CN9Ae1VHM4KEK5V9B+bFyX/6MZ6fFGZ2YCF5gwkD2W6gQeJpH8ARfJ
         DeXM+8dlMNYGaWF63iIngwQBG88nNwom3B7eevGGYJwZqFmzdg0ioF+qoVRvskJOLdWd
         yFEUq3Gk3StyYaLzt4rynZGQl2FwiF9YS9/M39UHgxxvFKW9xBrS4QTDz22vfWiHL2fK
         Yk+PTS6hkCGpx5Q7g+YmGYvND0slcwMZXZyIxKTjuVJYsHaig0mqewL3jXykjEMVGmhx
         5aC7zdZyD2cscascS7BkPBUf+BjIzggno/FVH7S6/BPiyS2hTlV3aIocSpexjTi3AoFi
         mh3Q==
X-Gm-Message-State: AOAM532P2kaszK3ZU3FxQLy1OFlg5UsKppCm8VQYTCTcBGyw+IBvC4Gx
        p8spq64ETFIzmxLxez3drl2Jqw==
X-Google-Smtp-Source: ABdhPJxic/QZR2BhX6akoIU8RQ/B3yNQzrr038cwGWxQtu13ObaIie5wUl501AIceUw/M1p5EPN2Vg==
X-Received: by 2002:adf:e346:0:b0:205:97d0:50db with SMTP id n6-20020adfe346000000b0020597d050dbmr18586212wrj.257.1650981737632;
        Tue, 26 Apr 2022 07:02:17 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b00393ee555683sm5414256wmq.27.2022.04.26.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:02:17 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:02:15 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Ymf7Z/BJQSWO6pjE@google.com>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
 <20220420141556.681212-4-fabiobaltieri@chromium.org>
 <YmcZn8mWQveT5HzT@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmcZn8mWQveT5HzT@robh.at.kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 25, 2022 at 04:58:55PM -0500, Rob Herring wrote:
> On Wed, Apr 20, 2022 at 02:15:55PM +0000, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,cros-ec-pwm-type compatible.
> 
> It would be good if the subject provided some clue what the update is. 
> Every change is an update. And all bindings are 'documentation' so 
> that can be dropped.

Fair enough, I'll reword the subject and send a v6.

> 
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml      | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> In any case,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks!

-- 
Fabio Baltieri
