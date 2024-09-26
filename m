Return-Path: <linux-pwm+bounces-3370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD26986E47
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A8C1F243E0
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3951898F8;
	Thu, 26 Sep 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PcxDir91"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1F1422D4
	for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337312; cv=none; b=W6ck+TPniSl5fxykoziK9fJdefBNyPzNdFhBt8zaxiwqizzJROjIJKr6UAX1W8snjmKNcbCCPMVCVsA8pPzSEZDrSEkzh0q6Gwju0M0MTrXKbBrBwolzPB292Q+JruYdOAr6umvy+RCeYoUxQO18rO5mRBfPBrySdKEqIv4fnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337312; c=relaxed/simple;
	bh=YVRCRU6UhPsLwCb4xrJkhgDMUl9fpoQExCURUKyb08g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyFO78DQsNRKJhULL9kowXAV5e2j1tHaFtPsOK0tWh+qeZddy06lx+CZPPUZDkSnovr+X4TubvycsZ/4R5y83L8UrcQmh7H2IADifkdNU0/tEXYgX76ZHMjkNsfoKsld5BOBsVreZDcEEQKUS0r/UaUo0YUUIlSrSy/koqVB+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PcxDir91; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75de9a503so6753921fa.0
        for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727337308; x=1727942108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Y3LBKzWWz0JTPIJu1jnjmO44NMJo/cD4/MkEe5rdE=;
        b=PcxDir91oRIWU2Srk1ZJhSlchEE+Uc7bb9SsFFFUhj9GshomHYup/TMfqCx9Ne3dlR
         vL+CrQnEYv9ujYL0YZCaAeUFYxjYGun10OMdiXQ7jRm0Ys/7pQQml9XqxBQEAYj6bQ/g
         ji3jnkbuXYeRKFF905GAaUuDYFqXwbTap2h3UJuKCbPvhIFnmkUzc1pUVL/6YNiVK40g
         OvzjJKxsDtderksiIUm2XkCC/8R9AsHT1XCVsl6rPjw2bIYxri8bH6Kn/HPm/dsdflU1
         TksHGYOgSnBQ8XFNL+wOSnBg28cReigFpedI8MFW94x6FghOePiy+YhMyoZz1xS64Ob4
         I25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337308; x=1727942108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Y3LBKzWWz0JTPIJu1jnjmO44NMJo/cD4/MkEe5rdE=;
        b=DoI/52ENNy8D39v9Z5M9oDvdYWsiZP/s0FL43CM3CoQdRymamVtyKS1HKjfoFR9oTI
         QmhHA2aMf6KVCY8xClWIcSDRYd3lNchY+q4OrqriFOpO4QunOFT7h3es+Xko7+aLymlK
         2fYDbz84jOA8g8yAIhtXDELDqBKcQwb9Bm1bubexus4Hxf55AjVlGW9gSWyNLrJcjTmr
         rFjXM/X1RarJNExaSsPvmuEQ9yHS56tGchv0gCcJRQvRoCrR7mFgzUlI0lVWDxBlBKVx
         AqlSezCozS5NfJm1BgTG+xMVA9LPySo/oqllnKbkWpsgecj+EfHX9TMLgEg3QV1mALhT
         CyLQ==
X-Gm-Message-State: AOJu0YxamE08Y6TzBXn/OSXSnX+xCE5DB2ZC2PPm1lLiFRea7kvy6f/Z
	CeEcJwec5LJkwdwTFjK9U0FXvjMgjAQtFvwm9uIbeL09if9fMEKZcj/yJ37tDvhX63UaziQj/Ms
	eSTT+NpJ1iIhm//0ilPJeLExeErAx8scmzd+3MQ==
X-Google-Smtp-Source: AGHT+IFkR3Y6XOk4k+dfm0I1kFBr9qpLnyXuqsfx0cMDKZODaEaGmqIUcQDdBPHTIZPDiPGBZ6W8Kh+s8FzCRgsqBD0=
X-Received: by 2002:a2e:4609:0:b0:2f9:c0be:3b0e with SMTP id
 38308e7fff4ca-2f9c0be3c0dmr19575751fa.41.1727337307686; Thu, 26 Sep 2024
 00:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com> <df0faa33bf9e7c9e2e5eab8d31bbf61e861bd401.1726819463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <df0faa33bf9e7c9e2e5eab8d31bbf61e861bd401.1726819463.git.u.kleine-koenig@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Sep 2024 09:54:56 +0200
Message-ID: <CAMknhBGPyOEA0ZT_4zi4on1mwi+ozM27uo1rTOkiWQtkU7+JGQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>

...

>
> The rounding rules that are expected to be implemented in the
> round_waveform_tohw() are: First pick the biggest possible period not
> bigger than wf->period_length_ns. For that period pick the biggest
> possible duty setting not bigger than wf->duty_length_ns. Third pick the
> biggest possible offset not bigger than wf->duty_offset_ns. If the
> requested period is too small for the hardware, it's expected that a
> setting with the minimal period and duty_length_ns =3D duty_offset_ns =3D=
 0
> is returned and this fact is signaled by a return value of 1.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

...

> +static int pwm_check_rounding(const struct pwm_waveform *wf,
> +                             const struct pwm_waveform *wf_rounded)
> +{
> +       if (!wf->period_length_ns)
> +               return 0;
> +
> +       if (wf->period_length_ns < wf_rounded->period_length_ns)
> +               return 1;
> +
> +       if (wf->duty_length_ns < wf_rounded->duty_length_ns)
> +               return 1;
> +
> +       if (wf->duty_offset_ns < wf_rounded->duty_offset_ns)
> +               return 1;
> +
> +       return 0;
> +}

It looks like this return value is being used as a bool, so maybe the
return type should be bool?

