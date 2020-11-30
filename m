Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C52C7F5A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgK3H4N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 02:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgK3H4M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 02:56:12 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E5C0613D4;
        Sun, 29 Nov 2020 23:55:32 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id l4so3527022pgu.5;
        Sun, 29 Nov 2020 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tlhpps4VXXl1XVzMESkL1pdScpF5cYOHwICDcu9T2Cg=;
        b=sA9vLnPEqzbO/Va1VEUMLXFZk5ZL3hBoR/BOLWSzDzRi1uR7Pr5g4lg+XTjp1cb60J
         /o1MB01lyNYSwVlzoZiYPBY+Zme3w2wmRNZoe4J1N6Zt27VzX4VVeRfZyn+4019BSiw+
         nTmray+pYly5NQI7ajGnpaxFNepGs5q0m48fZxSCteue8bglLQAoEFZ0z4Ex/JvUtpdz
         2jziJXX/ZXok0uSn1+LjDlFEn99wpiZA841Af0CVJKD8tzPv4tiuhFHobXjxLuGVHmRS
         SFO42UjtsOQa6kONtOmHsZ8WzOE/KXgV4ez3dDGH2bO6ByHyNXXrAY3jfSzcqoBhvHZW
         e7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tlhpps4VXXl1XVzMESkL1pdScpF5cYOHwICDcu9T2Cg=;
        b=Ff9mtUIH3VhwJI2Aod3kUzZE3joe2PMVE2qP87TUaAY02UHMdDSTlD/3IXQff8NUiq
         sF6nF+Ixo5RTplYIYH4yLr6rJTREHtJ+tq2YKIelYfxXN8xG6GcjGdPCRFOLXv3uluv0
         ojwYV3BqpWH3c8Z1Xox3S2NqCBTGk1OZl37HJPIPnFCFdMA6KTQKXtcCaGz0KfQdPiBm
         VQssDSgni/hTOR7HWpDfp1U1iib39iEGjZia/EEFVgiV03PnsyRYpJSUKkh40vkBUtu9
         ot3aAGzuuZOwjotN8uY4XIQTm3dBE+fjof8y9cyE5xyuHy5IT9tjkG+o7D8fDk28vdx4
         /vkg==
X-Gm-Message-State: AOAM530V7DQ2+O68o134X5Ajb06Mv3YR7Mhu1iIUbOOU2LuEUCENaIGT
        xOHvYFdh2TGDwaiJysKoiXc=
X-Google-Smtp-Source: ABdhPJyClsOt6799GnriPA/SIYXhMhfjVIdMRJ7PfCG8Sb8dUNWxEjGgKwivKSTxh9slkfSyK+zniw==
X-Received: by 2002:a62:5293:0:b029:18b:5c86:7ad0 with SMTP id g141-20020a6252930000b029018b5c867ad0mr17779615pfb.51.1606722932101;
        Sun, 29 Nov 2020 23:55:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id oc13sm20427278pjb.5.2020.11.29.23.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:55:31 -0800 (PST)
Date:   Sun, 29 Nov 2020 23:55:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH V20 3/3] Input: new da7280 haptic driver
Message-ID: <20201130075528.GM2034289@dtor-ws>
References: <cover.1606320459.git.Roy.Im@diasemi.com>
 <1e293e8c4830b09255af3b7e1721b73afaefdfa3.1606320459.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e293e8c4830b09255af3b7e1721b73afaefdfa3.1606320459.git.Roy.Im@diasemi.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Roy,

On Thu, Nov 26, 2020 at 01:07:39AM +0900, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.

I am looking at the driver and should finish review tomorrow. If you do
not hear from me by Wednesday please poke me again - I want to get the
driver into the upcoming merge window.

Thanks!

-- 
Dmitry
