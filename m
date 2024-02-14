Return-Path: <linux-pwm+bounces-1486-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B500D85475D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D531C2785C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B921AAB9;
	Wed, 14 Feb 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sr3hVmUX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BE1AAA9;
	Wed, 14 Feb 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907264; cv=none; b=e2uw0o5bPXMHQ3x5Zn4aFTSjRPMU7FAOIUzQsCmtPguDizTrAgQniFt4yynX/U0JNKYhZlpWGA1iGW18gFFNg2w0BcnzvUzMJmzVxKZsJHdA1k6MQ3Ui64tsN7l8xbpGr9AAomwb99aLcwX8JiFyAkZ8LxNwLG31CWvTiQlZ/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907264; c=relaxed/simple;
	bh=VJl5bhgxD5yzHXtWMP55IzVN/E8G4QOKln/nt+sDvgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE2w9W4AMxdoONebb5bDSf4JEtrb5twoqVLC6LA9O14pAJtCJeWWKxv9XICdzekCiFD+0sfOTgENVNoBNyuJW6fkRfxVs0heuLgy9Drr/z6KG+/CgzPfa34jTyDaiO266wFAZfVPJXgmdcZHABLfqKzGVbmahrPlNrcaJqBC/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sr3hVmUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5B4C433C7;
	Wed, 14 Feb 2024 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907264;
	bh=VJl5bhgxD5yzHXtWMP55IzVN/E8G4QOKln/nt+sDvgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr3hVmUXteGUYc2kUXj5wCEu23HQA88Sm5CwNZ2OE0Od2YEdS9KmIUL9TiuXv8Wuk
	 DHKhtTPoeWjvpwKedJ3PWbYAqvVe1EIcaSYkyV54nJ1FEX5EEoaQ5az9svKQHRKT8d
	 y3f7GkENsSg37WWGxl6sIwvZVYXdCLg82wMU4snA=
Date: Wed, 14 Feb 2024 11:40:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 156/164] staging: greybus: pwm: Make use of
 pwmchip_parent() accessor
Message-ID: <2024021455-henna-stammer-0b67@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <7e7517527b825a18ca10cb0faa837577d4f0ec8a.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e7517527b825a18ca10cb0faa837577d4f0ec8a.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:23AM +0100, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the accessor
> function provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

