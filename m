Return-Path: <linux-pwm+bounces-115-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB47F31F9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF91CB21841
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D351C4C;
	Tue, 21 Nov 2023 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bniw8I4O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4879A
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:08:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4079ed65471so27062165e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700579337; x=1701184137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nae4JbWQBA2aia/B95hNasr3I++DT3K8V5bSC8i7lEI=;
        b=Bniw8I4O8xww1+R9CFSXtkVwY5De5uZmI1EaZgyhAKu5rQfSLt5wvDnElgWndu6wRA
         GmtHIJL1do8SEBYu755CjIeZ6HDorS21qwWMZmHrk70Z2UWoESfqnlSui6rTeJ1AVkv9
         W5uOAaX4zrVSPpFcRXKhcAwt9kqOdcXglRmYTGqju3ottZdaPdy+FZ4dq+UtRH4W3Og0
         mHstYY3E8z/y3/UFcOYd43i5VaxshdCsE0Jd+EcVejPIPwDizCnNdzYELdtWI49HWspW
         BJT8JK5mNeVOrRxPzo7ikMPt1ioD0dyGb6N+WkjRqkO9wcc50sZkMC+28sP+0QgEWR3m
         47Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579337; x=1701184137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nae4JbWQBA2aia/B95hNasr3I++DT3K8V5bSC8i7lEI=;
        b=IVDYKhUQVL5P1Clbj3OGtadPzCc0auNSqjNI3mBQEXqGcXHuJE/a8xXcR9pUTton5O
         U1WqKe8EwHUcVHmGz8vjdaWa9TyJT8cFzM4VjA9p9puQ4KXK1XHSB9UlmZRzKCvSHg19
         e4HOzYnLkfekP0igdQ+Y36EHOxJzSn/rRhMV3dbObXLSpbSv9xp5P3WlUewYJvT1ToP4
         ifpol1g4FJe8GWzR1UZ7vc0xKgO0z+2l75bEOrRJ2XdsQRJniSuMJfwtKgbNJgqWB98A
         P92h07sGTstss0ToAyJLZg8oSLwEXNJLChXpgs9bxNCQnzNS+VGjmucR7+0LiEpBcx3N
         RdkQ==
X-Gm-Message-State: AOJu0YyypbrezyodrcSqnHHFoKayOoxNi3f13Q9Xtg0CCyjCrcZui6Si
	z8jdJ78KBI+6E2nvYNB0SxAJyA==
X-Google-Smtp-Source: AGHT+IH55XwOpCbTpm2nlb6uk8LPDmWMNuN4gHEZr7xfOXoov1mRLB8htGKYmkK0xC2O/BYriy6t0w==
X-Received: by 2002:a05:600c:4ed2:b0:405:4a78:a890 with SMTP id g18-20020a05600c4ed200b004054a78a890mr8499401wmq.8.1700579337271;
        Tue, 21 Nov 2023 07:08:57 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b004068495910csm21858114wmq.23.2023.11.21.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:08:56 -0800 (PST)
Date: Tue, 21 Nov 2023 15:08:54 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/1] backlight: pwm_bl: Use dev_err_probe
Message-ID: <20231121150854.GC4740@aspen.lan>
References: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>

On Fri, Nov 17, 2023 at 01:06:25PM +0100, Alexander Stein wrote:
> Use dev_err_probe to simplify error paths. Also let dev_err_probe handle
> the -EPROBE_DEFER case and add an entry to
> /sys/kernel/debug/devices_deferred when deferred.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

