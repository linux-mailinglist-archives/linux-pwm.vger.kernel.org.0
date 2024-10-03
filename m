Return-Path: <linux-pwm+bounces-3447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02298F319
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D771F22F36
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D311A08A3;
	Thu,  3 Oct 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt/lmGus"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD017A5BE;
	Thu,  3 Oct 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970358; cv=none; b=KdLwo7GAwxGm5KOTfICADLIrg14Nz/fP7Zs+iv8YdEjK1wiG7WShsKATbDun9rlPRx/KYsasPOUvFtc64cXxameSRE2ZuWDvweZNiykAtNqv4RlOy8bPJe1OnFny8kMzo2mpXnuCa8pZ46ATD4vB74FoIUxApfFG8fuvSagFAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970358; c=relaxed/simple;
	bh=DqThQ4pDP9vTG5GR7NWXXv/ygMY0KITCslz7wHpv780=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOKQsOOy5GK9m4pVCXYYL4tZzQI/eYlYCtYT3RAqEm4F5vAKbAkMdtd2uBeiBJ1cR8LPeNMjZHSvybQlGD43lrTwR9UAVwb672yDU3ID5TCvp7pEXAQ5Av9ISDJVrXtKvm21A8VkvnSLrCFo30B41DuOeD4UUb4Yybts/tgjR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt/lmGus; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a7bea3cfso76129085a.1;
        Thu, 03 Oct 2024 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727970356; x=1728575156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2nFqSHnerYWNOViSxQusgw7yMTCBN7rx6/Qgg/L014=;
        b=kt/lmGus/8d/DhKuI1Bg9cxv0L3bQyHYXOZRx/BXPVp7Y0nPAJvwwoN/qWHjsSay+a
         nQBxTzMgcdj9/FH89C96iOhHmNXeZKP66G1c897L5TEcRQTTYq9SaA+guegHfowIp7J7
         x0n+G0irOgPTYsCwym+pelv6Efwqp0cAsCtbRb2uQL1gXlwzr244M8rCIvVVXVUlv7q9
         DfrWH5axBRa5pmQzSb7N2l03+AWJCjonG/Tn/5SWxfZ2LOACgkMKnwTEqLDG5XhQhCPR
         ozn3mmQc59wL7/qatvhdva9n8/LB2Wfg/l49DKJZZ3jnCohdMGic2fLklDcZ+7HCbR9+
         zT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970356; x=1728575156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2nFqSHnerYWNOViSxQusgw7yMTCBN7rx6/Qgg/L014=;
        b=FLIp4WXonF7oLvrkMLf1R4dj7JI/mFPsgTGD5dGxD/jydBhtAYmyIoNz0bz3IgxGAF
         NS9vvhWKgaLySSBaSp/GJLlxSM5Visq986xCi5jkg5aLPI3D42zOWq66/jFJjWdDjwAJ
         cvESSW5zXPgDH5YxBEwm3OlyhVdpryu8UoZY6s/Mj3rF+7HfjVc+VOrvn1fc2X7UQy2h
         utZZkFgKo0IOoP5YHBCpwgEWhaFXgNqnxG5HSMKiNc51UAUWdR6YdJFyZASmvU9tS9Mm
         3J/+2XFyB1MYKl766Bo5xh/61Dw/jBuTb1oXsa0xsYirdTzEQKt8vQ2I6utY95Vi2Kue
         6HdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrykKD8goofGKXKOl2r9Zn11UQXptpFFt4dATXLQmgcurbMJUT3eUr0tUS3Rv5rZAGQA0aNCC2ZrT+@vger.kernel.org, AJvYcCV74Izoj0pP4OduKunZbZRMNJUqb4+OF+hwBFe7tTjwKOYY0BvpITPJs2wxdgNEgAmbU7mDpCBdQ3eqO7kZ@vger.kernel.org, AJvYcCVka0a6GkFYr7jbeRKUTBQyZqi5GnAH1V6A4encOfbL2aplLfXptnS1MHFklana1FyIncr60NFK/cqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/hVucxoHOAJT0aAe3OQlXPjIVxn0EHTCcb6e5i/zYfuePigO
	unt5BnwjEfL8Liv/3P84Xccu4ZcRnt6u+St4t3/0PlMYWMx2AYLj
X-Google-Smtp-Source: AGHT+IHZBTbeMUL5KqSIdlIsTi4jsvld9rbEJPgXHMZ4S9+FWr6RXYwMwnLXLpDeQReSAPIV3rqe0w==
X-Received: by 2002:a05:620a:470f:b0:7a3:785a:dc1c with SMTP id af79cd13be357-7ae62727a6amr1128481685a.50.1727970355946;
        Thu, 03 Oct 2024 08:45:55 -0700 (PDT)
Received: from VM-Arch ([2600:1001:b14f:5ed5:a130:4dde:abcd:f635])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b1409dbsm61011385a.0.2024.10.03.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:45:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:45:51 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Add driver for Sharp Memory LCD
Message-ID: <seex6vou5hig2qguejt7hfi5s5muikxch64f2d5fh2kcbs4tau@332xy75kvobl>
References: <20241002033807.682177-1-lanzano.alex@gmail.com>
 <t4lefcykpoe5i36wb4x5u23sseh6drnphtivuqc3mjviat2vvc@7hg4jyhxvpye>
 <ees3m2qmazah2547ys62zvbrvo4dsgki2z2jwulwz4dfjtm4hk@kpmlapv6occv>
 <q53inyaxyvfib7okxzazepxzarqmq4rubbasumvvx2woioyp42@fbtn4poujsyh>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q53inyaxyvfib7okxzazepxzarqmq4rubbasumvvx2woioyp42@fbtn4poujsyh>

On Thu, Oct 03, 2024 at 11:27:43AM GMT, Uwe Kleine-König wrote:
> Hello Alex,
> 
> On Wed, Oct 02, 2024 at 10:33:13PM -0400, Alex Lanzano wrote:
> > On Wed, Oct 02, 2024 at 09:56:38AM GMT, Uwe Kleine-König wrote:
> > > On Tue, Oct 01, 2024 at 11:37:35PM -0400, Alex Lanzano wrote:
> > > > Changes in v8:
> > > > - Addressed review comments from Uwe
> > > >     - Replace pwm_get_state with pwm_init_state
> > > >     - Use pwm_set_relative_duty_cycle instead of manually setting period and duty cycle
> > > 
> > > You didn't explicitly mention that it's fine if the PWM doesn't emit the
> > > inactive state when you call pwm_disable(). You're code should continue
> > > to work if you drop all calls to pwm_disable().
> > > 
> > > Ideally you mention that in a code comment to make others reading your
> > > code understand that.
> > 
> > Sorry about that! The intent of the code is to stop the pwm from outputing
> > when the display is disabled since the signal is no longer needed. If
> > it's best to emit the inactive state rather than calling pwm_disable()
> > I'm fine with making that change.
> 
> Calling pwm_disable() is best iff you don't care about the output any
> more. If however you rely on it to emit the inactive level,
> pwm_disable() is wrong. I don't know enough about your display to judge
> from here.
> 
> The code to disable the display looks (simplified) as follows:
> 
> 	if (smd->enable_gpio)
> 		gpiod_set_value(smd->enable_gpio, 0);
> 
> 	pwm_disable(smd->pwm_vcom_signal);
> 
> so maybe the logic you need is:
> 
> 	if (smd->enable_gpio) {
> 		gpiod_set_value(smd->enable_gpio, 0);
> 
> 		/*
> 		 * In the presence of a GPIO to disable the display the
> 		 * behaviour of the PWM doesn't matter and we can
> 		 * just disable it.
> 		 */
> 		pwm_disable(smd->pwm_vcom_signal);
> 	} else {
> 		struct pwm_state state;
> 
> 		/*
> 		 * However without a GPIO driving the display's output
> 		 * enable pin the PWM must emit the inactive level,
> 		 * which isn't guaranteed when calling pwm_disable(), so
> 		 * configure it for duty_cycle = 0.
> 		 */
> 		 pwm_init_state(smd->pwm_vcom_signal, &state);
> 		 state.duty_cycle = 0;
> 		 state.enabled = true;
> 		 pwm_apply_might_sleep(smd->pwm_vcom_signal, &state);
> 	}
> 

Ahh, understood. I looked over the datasheet again. It looks like in the
case where no enable gpio pin is defined we'll need to keep the pwm pulsing
since display hardware would still be enabled.

I'll fix this up in the disable and probe functions.

Best regards,
Alex


