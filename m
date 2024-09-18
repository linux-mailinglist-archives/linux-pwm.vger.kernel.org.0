Return-Path: <linux-pwm+bounces-3289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3097BC91
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CE81F256B5
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527C189F45;
	Wed, 18 Sep 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah2XXmak"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD482189BBE;
	Wed, 18 Sep 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664029; cv=none; b=NvNLSnVCzT0VWwY8KZILof7q+ldO6Avzk1iD+PPUcJ99/0ONVoTsi6aLD9mCwctSQqD8PMByv2OPglQkKh2Qehgs9cHLhjjaYRljbyU3CdAmoGM+zzpDVno39LLurYlUoUjeI90op41ETWXOoP85SImiiV3mHux0dU1Av2i9Qz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664029; c=relaxed/simple;
	bh=o7BH08dOrugi4nkBMnNUfU+B6Wt6p41IPzWcjUkFlFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6jc5iX9Bv/CJGXe4NI6UUh/uYFbzFU8z9DlGo48quLySjqNlmo1B65ya72bivZcTqZgmt29erKX6qCaTf1ca9indLi5zGJrmtzoK+xm8iWJ6YIHuTkUK9UZrpSpL/koMXA2Z6D50BzFNSQFI2O2ZMLy7DwzePVr8yKPaIhvlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah2XXmak; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49becc93d6aso1939784137.1;
        Wed, 18 Sep 2024 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726664027; x=1727268827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g9NdqeVcPa5WEMV/Sz1b6LsprRcVfh5a8jA898vriU=;
        b=ah2XXmakCk6CbSAzsfALS21qxd9YbB9mmTi0oNqb+oBOeWZr95K2sP9FBsCQLmlmfW
         Q+zlmqcu9zx0vhlW69IixlnUJAuI+irIL7UEJCc9Dy/Lt2OpNrk5qkFlhBdup0ssffe7
         6HszpG/+Op2qPmcoyoEVQd3m+SjOLLKJDxJ5Gosw5GrnwjdukXjVdxDf4vNcdknQvecT
         5EGxNvHvHX5dP2enBQRN9H3/qGv30EOBRMqyYoFRGqn30k/6ZIDoNqtrX6OFCm3Q8HOS
         GndmomhDYgiWfckSxotEhA0XIcfldzF7YgiobUWFQFccLEzdaBjHV1F7aYs4J+NohLhC
         EqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664027; x=1727268827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g9NdqeVcPa5WEMV/Sz1b6LsprRcVfh5a8jA898vriU=;
        b=V7NXa1+2lWJ5RVdpAaRTqzYXGFftJSrtXVN2YUMN38kNlLVp9TAnICvGiAxkEf9H/b
         6mMyPcvghmAriCXKA9bUeldk13LNUefIbddtbwBUbuTRO/MWgo75jRC6IZt1TMoffRTp
         lZ2/uhKDcbP+txWXaxWhP3Wi6UgQOotVSUMoHFewU+5BqoYsQJ7dq1bEwWahpKl4QqQF
         nhQ1O5qbaVUWvMB+Cj5yx/iZADOLlbEYu9gw89O4Azbwi3bYtkx/bOoba0ZgMXsQP2xs
         +aTL55QfznK9ySSp2G+xPC0KDlQAtw4UELwDhMVxGjvwwdKNiUHxFFOytuCxVnBusixO
         gFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJOVZQl1QNsfS0M/16wfo5P5OuIkB3YO9al3EdkIY9Y68GysOgBamPB7bSUNfFbHA7Sy0UILmIUn9PtPydpmQ8bQ=@vger.kernel.org, AJvYcCVHHyQrZQ7Fk8GNjfj8QQ3VKUGW59rAECEOC9fIE7sjbwpDVi5BsJ2wp6hdZR0Bs50VaFbH2KfshDSR@vger.kernel.org, AJvYcCVIuiqG5k+32dIVV/cEJ7GSNe+4gr26/1ygfW7dfTkmpIik8OHJDPuJmdIW8EZsmBA11w1Z03slFp5I@vger.kernel.org, AJvYcCVTEJE2TQWNx0suFmjtZ5a5IJh+TtQwfPTFFBhTvFxSZGQ+USN8Vyey8WLeNkXmR48Gl6BW4vHcw+kLC4U=@vger.kernel.org, AJvYcCW9oc8R/9q1zt8rszvbX+vreoeQk+dmNz/UX7Xr9Lbg+9E8uaMoKY/zpuWai9TthM/XOcy6/3YGnTU=@vger.kernel.org, AJvYcCWUdtMu6Q3rLt7XfF1aaIyq+OY5cv9+VkxU1z1pqNh15Fb6n+aY4N2c4ryWsJxbpwCGCNQroYss/NEPoA==@vger.kernel.org, AJvYcCWcrVvktCBo33ZCF0LVmXMIbSnBAjU3gMNhVuv4wdn33PnPh1+tTfCB/SpMHEpacTdmczG9AWxQnV2hpWr7eg==@vger.kernel.org, AJvYcCXWt2PCdpIxr+x6nCde8DTqXpHZ8kFFXF7VYMjTuVf3MCqDLdmPU1emZ6+rarXekCgPpJVVvlq55Vwn@vger.kernel.org, AJvYcCXd66fI7PXrKyenx49vANalHSGgVvFeFy2KX1E7OukAI+29UkpAKSBb88Lmu1TGegxbnkjVSNO6QBOwLLIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxusXEQGUTWCeBe8DJ5WDw2Idow0JmE/o7y1754bFjU1kpGZohr
	jPxxFqwO0qew1epPDn6TVbjdxlf4J+YPkVUyzEMg6Zdd7NQyrrk/PeoEMV4Jt6PnmL/5ibQBMa5
	c+B3Q+LIidRAwTTkyrqhG6hFBW4o=
X-Google-Smtp-Source: AGHT+IFGmph15ldtpeLTYgiO51oUhmQH5ahITzDspFrnSZzNrk9TuFGJLzehC4MTF6p1O8lGGsMcGjzI/fRVh7pjEYU=
X-Received: by 2002:a05:6102:3746:b0:49b:facb:15f0 with SMTP id
 ada2fe7eead31-49d4147e852mr16147058137.12.1726664026626; Wed, 18 Sep 2024
 05:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-8-2d2efd5c5877@gmail.com> <wywp6vj2pqqe7to55k7ssh5sbqrmy7emvwruvm2waytancf3r4@aygtw3y6huwx>
In-Reply-To: <wywp6vj2pqqe7to55k7ssh5sbqrmy7emvwruvm2waytancf3r4@aygtw3y6huwx>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 18 Sep 2024 15:53:34 +0300
Message-ID: <CABTCjFAvXYrRJS3Dwf-TMq3OW_vN1hskk+qPjosbRym7xOvy1Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/27] mfd: max77693: remove unused declarations
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 16 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 12:1=
0, Krzysztof Kozlowski <krzk@kernel.org>:
>
> On Fri, Sep 13, 2024 at 06:07:51PM +0300, Dzmitry Sankouski wrote:
> > Remove `enum max77693_irq_source` declaration because unused.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> >  include/linux/mfd/max77693-private.h | 11 -----------
> >  1 file changed, 11 deletions(-)
>
> Please split your patchset per subsystems. There is no dependency on MFD
> bits from your DTS... (if there is, this needs to be fixed anyway)

Indeed, my dts has no dependency on this patch.
However, my dts has dependency on MAX77705, so AFAIU,
I should send this patch separately, while leaving other drivers in same
patchset, right?

