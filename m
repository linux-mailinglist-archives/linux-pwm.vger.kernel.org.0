Return-Path: <linux-pwm+bounces-3670-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F89A0226
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 09:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8FEB22A60
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 07:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CE9199956;
	Wed, 16 Oct 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkzq53Z3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F2433CE;
	Wed, 16 Oct 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062600; cv=none; b=DEd6WQS2viyiTSatzQrteR1kKLqcaaeBFpFpDuYOVA+qrHnPuBuDOgaa9SgeR7SWAdD/j8E7QEY/uX+sFQgolTHO7e3H7TZWlTlPa+JNmEvbG4wFJnKN8QbZ4qgUTc3bobpusnUoFfoGoFqMrOzlpehCyOF7aD5lNIscjRrmNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062600; c=relaxed/simple;
	bh=B0GKr6WOhiuRqudv+tvK5QEUyvpkJHEvn125P9EHBM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeBvc3MnPtu1lsbMogacd//KP8XfLyxswID7XdrDJK+xD0XhyF5E6C8q/g0bZW6SGQ2G0JkVerE43lXaJvUUq07qsbv+RITaq6YM5rXvhv2RuB/axkQpYJtanGbOEjV0obITja8AcOggO9fMZLx5A8S50nhRFP7TUkfQnuibpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkzq53Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E92C4CEC5;
	Wed, 16 Oct 2024 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062600;
	bh=B0GKr6WOhiuRqudv+tvK5QEUyvpkJHEvn125P9EHBM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkzq53Z3KxRDOtQMzF9EBgYrvGUDYlSNmtV/ofKDdDiSPjlA7/huK0D0LKhxI9TKy
	 Su/T0+DCJnjjC3hhq+5Ht7w1UyneZPB9M2rS9B8TvYTrwx9Laewo0siIjC7akeqo8S
	 DBRemRNLKF1lRxdxEVSL7xmtvKrkOSTxrmSTiffXkADAztb+E2VpHxq5sNXSC18iVF
	 b7F9d4D6mCAC2EXJ1tN/FRz6xjF4nDA99tcgOI5Y/Fzur2NP94FPSX/f2Pxt6XcXQn
	 W3ip+ZH/5i93ZlK3wPrvY6rp81e8I7UxKOS2CVicexG4RiCA9Xd+Q2RsRA9uTOyJsi
	 9UGpyAsPgCwWw==
Date: Wed, 16 Oct 2024 09:09:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com
Subject: Re: [PATCH 0/2] pwm: brcmstb: Support configurable open-drain mode
Message-ID: <5ub3shbkriblqnn7kupyunyoa5a7etaqle5cls4o5oiedx3ylx@tokosop2mp2m>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
 <2lxrtu6mnzs4v6h3x7skbmxwtdmhgn7g3qmmxyr5n4lof6lkb2@6rfckn2g45ho>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2lxrtu6mnzs4v6h3x7skbmxwtdmhgn7g3qmmxyr5n4lof6lkb2@6rfckn2g45ho>

On Mon, Oct 14, 2024 at 10:05:40PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Florian,
>=20
> On Fri, Oct 11, 2024 at 07:56:01PM -0700, Florian Fainelli wrote:
> > This patch series updates the pwm-brcmstb driver to not assume an
> > open-drain mode, but instead get that sort of configuration from Device
> > Tree using the 'open-drain' property.
>=20
> Just for me to be sure to understand correctly: A kernel without your
> patch #2 behaves identical to a kernel with that patch if the open-drain
> property is present, right?

I don't think it does. Patch #2 breaks the ABI, IMO.

>=20
> It's not clear to me why totem-pole is the better default and the commit
> logs don't justify the updated default. Can you improve here?
>=20

Best regards,
Krzysztof


