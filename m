Return-Path: <linux-pwm+bounces-1508-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C662855422
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 21:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5069283C9A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA45128370;
	Wed, 14 Feb 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFVHaj0C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CC55E45
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943486; cv=none; b=IsohMQBI+c25UiksE7r3jkJmC/9dAFR5u64z7ib5j2z4pDh7MXbdHCWx4GV7LYUSCHGgNvEurb0NZYz5sqU/WOPeBFR0KZ1RfNMzpE7y6fNww2QoPnOMSYlNqBfYiTEu7yP7yrqi1qFq1CsF0hwj+kL2SYFzASkzuqfqAoF0+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943486; c=relaxed/simple;
	bh=Jm0no+Vtw803w7EPuNt6UoKibiMj/t5yX/40gxpSGio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CISb8uwY7cwHev7vJ6hrbfQuTFcrHscr+NOEl4Km+CY/6OvYA5ByZkE5fg/85uZDXZEEdcwAqfc1ohdLdo73iMGOxJtN3BuQSTybaKTPf5QDU7l4TRmiMG/3HIoi+5AFwBxmStS0xTwBE1gjvlu4A6xtN6PgSwnSBECEUFw/OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XFVHaj0C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5638447af43so235256a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707943481; x=1708548281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyCSWtxgPuL2OfFY3ZzcZyBxJluRQFv9i6WqBwPxYWU=;
        b=XFVHaj0C/Hp2lzNh8AoaYz8+LdRz3zFVGgw8zMwjtUAjQZH3kkNNbTa0GgnF+KDS4L
         CbbzgyC6kzU6Jq6NPMwjhw3Tg0and483I/nKBeSUMwz7JzjBbVNe1QgCPu0TovICOkhb
         aEEI/lMDVbuifJBCV+QV7R6jUddUzmQzRBhlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943481; x=1708548281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyCSWtxgPuL2OfFY3ZzcZyBxJluRQFv9i6WqBwPxYWU=;
        b=nloEdOS32n9JDbkkhf0bspWHLV9ERcLHxLiJVkPS1e86aAArYiwkRQaPXilG82eNp2
         0iVCPu5Iz9agziuDLeDpJ99zW73mAOTGFDACxCWTy10g9rVYYzMuI65WAwaYviLkAbw0
         IBZxIQwExrvd3iaE8pJeuT8rHGKJwCD5v0FIsuO8QtsDKTwmGNGveRP1nMuXtKfbaGTl
         ua/OEltsLvL3MFmewYvQEpgwt7/zABLafxBUOPIrMZlk4xvzkSJDPjvlgEy0SNTCY21E
         u/muN8bii4DGuY9KYSgnae6wPQv7FF8kMzyoHbGj9fskYRiF1aZc4Cp6QJcymSr5PjCB
         WtZg==
X-Gm-Message-State: AOJu0YwjhbLJLg91RYq7QMTth9R+i6iN5++T9evGAXJ9xnaCNF56+/cQ
	If4QLU+47z/wVz/+VCIu1knYJWO9RzbgDoSf5YRB6w0KJpL91u4M5gdwUa+1607gPN7vjrxKiy6
	schvP
X-Google-Smtp-Source: AGHT+IGbAlIY2FTA8WYIJeM4dofkTeX/t5aETfHga186T2OJXHUsoUE3mLjxfCdk2F0u3aKPsMIoBA==
X-Received: by 2002:a05:6402:124d:b0:563:8b25:164a with SMTP id l13-20020a056402124d00b005638b25164amr1596651edw.11.1707943481351;
        Wed, 14 Feb 2024 12:44:41 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id l20-20020aa7cad4000000b005638a4f935dsm590348edt.4.2024.02.14.12.44.39
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:44:40 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410c9f17c9eso1125e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 12:44:39 -0800 (PST)
X-Received: by 2002:a05:600c:1d84:b0:411:d4df:761 with SMTP id
 p4-20020a05600c1d8400b00411d4df0761mr329588wms.0.1707943479685; Wed, 14 Feb
 2024 12:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de> <10a8d55110fc48a4759e65cc19556858587e94cc.1707900770.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <10a8d55110fc48a4759e65cc19556858587e94cc.1707900770.git.u.kleine-koenig@pengutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 14 Feb 2024 12:44:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WkJOd6P4f=j0BHfm+ZeHnCtMBXALDWVeypdcirSTQp1A@mail.gmail.com>
Message-ID: <CAD=FV=WkJOd6P4f=j0BHfm+ZeHnCtMBXALDWVeypdcirSTQp1A@mail.gmail.com>
Subject: Re: [PATCH v6 152/164] drm/bridge: ti-sn65dsi86: Make use of
 pwmchip_parent() accessor
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 14, 2024 at 1:34=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the accessor
> function provided for exactly this purpose.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I don't see any differences from v5, so not sure why you didn't carry
forward my Ack [1] on this one. Maybe because of the questions I
asked? Your answers from v5 seemed fine to me. In any case:

Acked-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DVqPCbfTP86Wewf+-o9_v5oLsQUu1Dqb5EM=
LZZEsqGmRw@mail.gmail.com

