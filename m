Return-Path: <linux-pwm+bounces-4940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD9A39488
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 09:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE2188BBB8
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Feb 2025 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0291DE4C2;
	Tue, 18 Feb 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsLnlksF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AC1B3935
	for <linux-pwm@vger.kernel.org>; Tue, 18 Feb 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866212; cv=none; b=kuXGBFnCrKg2GTgAZ/A7ft5dOcSXoBtUHEdjMGb78dNIY9BH65J04XKLH6h4Qyz/eTSKhpP0OW0GI2STU5/YzyglDHJUewIvOEkgUT8kVTLnVcITTsurGOqM9M/6Es/sh8FfIJoo2A9TNjekW0n5ugRPSv1faXFTs8Xfw4H7ZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866212; c=relaxed/simple;
	bh=lm4izQPUPAxU1EFbWA1X1QGgm3ceV+i3LzDKWszTFuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKH4bl7DBLVIbrVOvFNdaeN4dZS7+xpJyqGnSw69zIZ2OeAPNl+omq/HuAJ17SR0T1xTE4Ibd6Cpx0G5RpkT9l8o6QHxN7/gpl1LyvJn4WfVNEfZV/exmcYmgCZBIuo233UDnWET6Bv8PkYnv0ktzyrpVc/8J48V0hPPzD/duNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsLnlksF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ACCC4CEF1
	for <linux-pwm@vger.kernel.org>; Tue, 18 Feb 2025 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739866211;
	bh=lm4izQPUPAxU1EFbWA1X1QGgm3ceV+i3LzDKWszTFuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RsLnlksF3ghInRjfQUK2RbEcqA4utlAXSkdEuDOes0UY6OEHubhGH9LV9w0k9HI8g
	 w1J2zhebwtjsjUt4moRwPvipUmD9TWYTLhxBahQaztXJpd/ttcbtVYAUf6oXMGBc8f
	 /BoLRhvbRBbtDq8W1mIuSvv++WQD/pQhNElF9lqTSyXApYZ9WSvSP289j7maCKfmfg
	 nyA9L/dTpKS9Sgn2IZPKsMeWXVklaBgV97Io+6bXR5YI7sC8yVFIHhQZEBoeYscq3L
	 3XlFCrk87mclPoiw8aFg9O78aCThHrsEw6GrIPNEMT3as1PHG160dthI0sNwkm6ef4
	 xaR1Aeas7lbdQ==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e589c258663so5544324276.1
        for <linux-pwm@vger.kernel.org>; Tue, 18 Feb 2025 00:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPrJk9bTFdczg5yLqLuKuUqfMSf3iOtvOISxoho5wYlzVsLL7zxKPUpdm0kAhm+K/WW68uFSHHBKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTN2OVx9n6eGWaDTVuLfqV660LPy6KYr3PDO+pKgpXxBulvW77
	q/vq/a+zORXPrPZ5GB6TqkKIUQFHaXEzOfNEdkPcnYsSoiMN56HSENgO5AVqqIMw5R86nUEe8Xe
	WlcFVEvjUsj11huUQXCca/gZhLgZnc4kV0SWvcw==
X-Google-Smtp-Source: AGHT+IECc7JXf4PulZUAuqjkIE4N91vsuo67KP4yMuA2IEZ6yNrlZtVPBQlMqGyALdhW2ompVxgJOZSBbCCzz20fC7A=
X-Received: by 2002:a05:6902:2ec1:b0:e5d:d4e3:ad8 with SMTP id
 3f1490d57ef6-e5dd4e31aa6mr7029201276.28.1739866210764; Tue, 18 Feb 2025
 00:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217174936.758420-2-u.kleine-koenig@baylibre.com> <519b82d4-7904-4320-93e4-efda799b545c@bootlin.com>
In-Reply-To: <519b82d4-7904-4320-93e4-efda799b545c@bootlin.com>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 18 Feb 2025 09:09:54 +0100
X-Gmail-Original-Message-ID: <CAN6tsi5MNzK5piULQN4x7r2np8fF2RaPxpksPszP-GBTW+4b_w@mail.gmail.com>
X-Gm-Features: AWEUYZlCU8GZZu1AIfPxJ-K_nmRqCoXWLxYkqwQTskKMCDCFCP1jOIC3mj0uPHo
Message-ID: <CAN6tsi5MNzK5piULQN4x7r2np8fF2RaPxpksPszP-GBTW+4b_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Check for CONFIG_PWM using IS_REACHABLE()
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Douglas Anderson <dianders@chromium.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:55=E2=80=AFPM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 17/02/2025 =C3=A0 18:49, Uwe Kleine-K=C3=B6nig a =C3=A9crit :
> > Currently CONFIG_PWM is a bool but I intend to change it to tristate. I=
f
> > CONFIG_PWM=3Dm in the configuration, the cpp symbol CONFIG_PWM isn't
> > defined and so the PWM code paths in the ti-sn65dsi86 driver are not
> > used.
> >
> > The correct way to check for CONFIG_PWM is using IS_REACHABLE which doe=
s
> > the right thing for all cases
> > CONFIG_DRM_TI_SN65DSI86 =E2=88=88 { y, m } x CONFIG_PWM =E2=88=88 { y, =
m, n }.
> >
> > There is no change until CONFIG_PWM actually becomes tristate.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: Robert Foss <rfoss@kernel.org>

