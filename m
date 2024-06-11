Return-Path: <linux-pwm+bounces-2411-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BC90370F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BB9287B09
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2024 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AB175573;
	Tue, 11 Jun 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgQ7W1Gz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25717555C;
	Tue, 11 Jun 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095847; cv=none; b=DAdN4cp/W3deWryqUDzFBbtQMvB72nq+NLcMll1MuzJpPaAcxJeq3p/oPr2bh3VsAVJvE3lQ+qBvyIBvQx/bf8R2kOfuPcDdnVUxLXSUqJMRco64EJnwuZzlVxHtEeS/+04n1Iq69qcg0sDvTMNfXKTlt2XKhZqgRhCmtYlgC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095847; c=relaxed/simple;
	bh=x4IeccqboLkC6pu6d+XHWB0qsYC62Jw6KpyPHteDycU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKAJA1epzF31b39/sKG2FHkvxdiYzsagb1aGzzAdBsgaHjnNSbyOz+0fWMBtwMI7nMPxC8Qn00dzCeUeExFWX86V4ZrKZaGZfKUZRi4FqlXC0NIpBA0RZk386XagfK2TZulHKPTZFfk9HccWw72zk9XVS+c1kMjErH8MEM2si8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgQ7W1Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F57C2BD10;
	Tue, 11 Jun 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718095847;
	bh=x4IeccqboLkC6pu6d+XHWB0qsYC62Jw6KpyPHteDycU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgQ7W1Gz2OXH5mdHXx6txC73K+8rJL4eA0kfjYVK1/tfR/BJgcP4DaBB4rSyDR++N
	 o9l8TbXiqXRi9IUPwg8hT1e/ZfvtS/6Bc9lnyC/l9ZVlYCGgTzN98NU3EKWe8MXOch
	 PHgQWF8hyuMqI/g5ySOYlf8YeDogRG2RRA+75KtiXQHIaZkbMFAreZdhNdf8gXM83j
	 SRPCdxmaAVxoLdLlOUKgD/AdFjRRP71CPWWmkLA87A0jBjyAg/sBlczqjWCHnu2+7d
	 SBV7atHfVYZH2mkk/YWzObDHFMW1+VZohaCDBwU7oHrRy8AmKmsoDyMo0/7Hw3PAuq
	 PVP5zfxKIvbFw==
Date: Tue, 11 Jun 2024 08:50:44 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <ZmgP5NTPEGM0M2Li@google.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607084416.897777-6-u.kleine-koenig@baylibre.com>

On Fri, Jun 07, 2024 at 10:44:15AM +0200, Uwe Kleine-König wrote:
> The get_state() callback is never called (in a visible way) after there
> is a consumer for a pwm device. The core handles loosing the information
> about duty_cycle just fine.

ChromeOS EC has no separated "enabled" state, it sees `duty == 0` as
"disabled"[1].  1db37f9561b2 ("pwm: cros-ec: Cache duty cycle value")
caches the value in kernel side so that it can retrieve the original duty
value even if (struct pwm_state *)->enabled is false.

To make sure I understand, did you mean the original duty value could be less
important because:
- We are less caring as it is in a debug context at [2]?
- At [3], the PWM device is still initializing.

[1]: https://crrev.com/0e16954460a08133b2557150e0897014ea2b9672/common/pwm.c#66
[2]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c#L52
[3]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c#L371

