Return-Path: <linux-pwm+bounces-5151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF31A5F59B
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6354B1759DB
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F30267717;
	Thu, 13 Mar 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivTQH25/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26731754B;
	Thu, 13 Mar 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871515; cv=none; b=aexollZ2XLe8wWImZp4ISM7SKKR7+7AyD/MI1opMHqdnJpeGReneBy5YbJ9Vvbqqv+iBFxGrrQd513hImEXdAhIm12UlWkKduUDsmtqmGhKCeB2YVG47c5Bz2iUqwJzc3B1pXqk2U//JjAURGlpiIACD9X78jGmWmGJtpLnJJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871515; c=relaxed/simple;
	bh=7i8lFQHEUpDr08x6KdoFcD/Thz3PnkKOQjF8h2Byw3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H3kkqPVkxQRj5Cwxxqb6o651jowc4poMx/k9KbA/QG5wTpKIfaOg4lTt+EJlYSroHVO2Tr3R7PTdEg1Mh2B4A3VSyJJzM0Ld2STWj+Oy6+Xuvc87ruKjCe7OVbCPsAyK7CD+cDr79v4yY4CerX2Vu6lQGoRvLsY2ENxXojCzf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivTQH25/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AA7C4CEDD;
	Thu, 13 Mar 2025 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741871514;
	bh=7i8lFQHEUpDr08x6KdoFcD/Thz3PnkKOQjF8h2Byw3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ivTQH25/HXRvQ4owiM3+ef8YXwFdiaiUJZ9gzd4GQ9VD58DxR6538nmYeitCWuwDs
	 PN4FNiRGRcvma+coJfos67eI7jiYPAwpEh+LhsGLQhj65FmM9Ccr0wuKbC3dM8jWjg
	 PMaxDoHGKxS3lfgibLLSFUKtI4ebCPvQWpfeTQCjw8ETLFraosc0eHGmpONaemW59G
	 pQIGdjBUDiJ8lMwTCZo8jJGMHiXr1fdNQvxEDvjhBJvkTPEA6AvaFMdeZb8FcLLVom
	 8GNPKPYwiOrsB8zTuSxrosdZSh0Cqo5OFtaChfsvNNRa7K19VjcTSyxOJ7rZt80jfQ
	 lhXZRqH34i2BA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
References: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
Subject: Re: [PATCH v4 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Message-Id: <174187151094.3638901.18192450967481384067.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 13:11:50 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 05 Mar 2025 15:09:03 +0200, Abel Vesa wrote:
> The PWM allow configuring the PWM resolution from 8 bits PWM
> values up to 15 bits values, for the Hi-Res PWMs, and then either
> 6-bit or 9-bit for the normal PWMs. The current implementation loops
> through all possible resolutions (PWM sizes), for the PWM subtype, on top
> of the already existing process of determining the prediv, exponent and
> refclk.
> 
> [...]

Applied, thanks!

[1/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max for normal PWMs
      commit: d3fd20cecf7fcdada938429ad525daf5b2217a7a
[2/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      commit: 638fc32c056aa62c7add071205de6acc479ee37d
[3/3] leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs
      commit: 227fc065ae9e707af9c7d346458f43fd25cf310a

--
Lee Jones [李琼斯]


