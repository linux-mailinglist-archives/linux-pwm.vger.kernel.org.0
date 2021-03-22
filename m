Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5283452FB
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Mar 2021 00:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCVXaC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCVX3p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 19:29:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18004C061574;
        Mon, 22 Mar 2021 16:29:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so9303297pjg.5;
        Mon, 22 Mar 2021 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U/IBmLp8QkjVB/SzgsK/2A+PcX1LFcU9lJnWkixjLUk=;
        b=XG+yurS4EUzoBdPJxud6mro8oq863CFyPC7zxbgHi2O7EHmpr0CRSmdT2B2Za96O2D
         eezVz+iVtNAcPA4h956V+7btkbHcZtQiq7XrxE6o5LTQfN/Pt020g6E1Y8IlcGGqauwI
         TgDc6rLBkQvtkBI72WI1CoQHZGlEp0KI3Bz16pjvs7EXk3LmzKRZKvgghVw9XTWkX6sG
         ueC9ZnFYb7mMyO3RRFR6EG5G/I3/+QZcLDeAcwocKkZYC+C7XRqIpw2YJd8XI3zaFVw6
         pbTkROP9GB7xDfunCHPF1mR90gNrPbzK2ldJiDBtx13g0jtAH2LNWCSoS0gXJEzWusIz
         zPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U/IBmLp8QkjVB/SzgsK/2A+PcX1LFcU9lJnWkixjLUk=;
        b=slaBjJCYFSXJ9IDqVqv7qXQRO53+O9UiWrpOIbxZP3Tob43Y+NXF5mcD4qLiDiYVcn
         jVeUcR87aiPIeK0eewH5zNg2gkismqXW1YYRpepgxd5jX2iC2zJUAGxfbWNLbnyi/ct7
         v0MQ/cK+PCd6o/ijeQMr2rgq5PF4lxEg9+1SxZzIWAUh1svUNr5zN0Avf73tGsSS9414
         pNrkBj/v4NS6CFl37Vtr31Uf6FseA4HZYv+bivUV1DUnZ5x1UXRIZYh6D6OjyxcbzfDP
         a9J+GkeT1d87SOj46jZStpyiO87wRF7st+3EAw54+wLjpDh/j6d/HE6djxE9UWH7en0f
         MDUA==
X-Gm-Message-State: AOAM5315RJtyOIchV5H1ggj4L+HVJSrjg/d1iV7vGPMrZToM66P8XQNn
        +TY/EAQwemgFhW+csT7TeNQ=
X-Google-Smtp-Source: ABdhPJz/tDZ30C8PiBsuFxIrZ2KEotS2s7Xw+gnv0MR1HNPjfDVu03faBkOxmgcLbN2vTOGLh3nRKQ==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr1404366pjb.183.1616455784445;
        Mon, 22 Mar 2021 16:29:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:499f:7361:582b:fd05])
        by smtp.gmail.com with ESMTPSA id p22sm432999pjg.39.2021.03.22.16.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 16:29:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 16:29:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] input: misc: max8997: Switch to pwm_apply()
Message-ID: <YFkoZKOEkBg6wdV2@google.com>
References: <20210316203813.48999-1-uwe@kleine-koenig.org>
 <YFfHciL2CXX0aERa@google.com>
 <2972bc70-2535-0c09-faff-b74f6842fbc4@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2972bc70-2535-0c09-faff-b74f6842fbc4@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 22, 2021 at 09:16:43AM +0100, Uwe Kleine-König wrote:
> Hi Dmitry,
> 
> On 3/21/21 11:23 PM, Dmitry Torokhov wrote:
> > On Tue, Mar 16, 2021 at 09:38:13PM +0100, Uwe Kleine-König wrote:
> > > max8997_haptic_enable() is the only caller of
> > > max8997_haptic_set_duty_cycle(). For the non-external case the PWM is
> > > already enabled in max8997_haptic_set_duty_cycle(), so this can be done
> > 
> > Are you sure about that? I think the intent was to enable it in
> > max8997_haptic_configure(), and only after "inmotor" regulator is
> > enabled. If the device is enabled earlier then I'd say we need to make
> > sure we disable it until it is needed.
> 
> If you claim you understand this better, I will well believe that. I
> described my train of thoughts, i.e. how I understood the internal case.
> 
> Anyhow, there is little sense in separating configuration and enablement of
> the PWM, because the change of duty_cycle and period for a disabled PWM is
> expected to do nothing to the hardware's output.
> 
> So the safer approach is to do the pwm_apply_state at the place, where
> pwm_enable was before, but the more consistent is how I suggested in my
> patch. If it feels better I can do the more conservative change instead and
> if somebody with a deeper understanding of the driver and/or a testing
> possibility can be found, the internal and external cases can be unified.

Yes, could we please go with the more conservative approach as I do not
have the hardware to verify the behavior.

Thanks!

-- 
Dmitry
