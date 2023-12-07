Return-Path: <linux-pwm+bounces-435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250FD807E30
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 03:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB06C1C20BCC
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD21841;
	Thu,  7 Dec 2023 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIJZd/Us"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B917F8;
	Thu,  7 Dec 2023 02:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2B7C433C7;
	Thu,  7 Dec 2023 02:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701914788;
	bh=QudyBCcyUGVMqpgzaWlXkbqLRvWGAeM0uhNwakY1NMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIJZd/UswEP6oGmOQ2npG3k0QC2r7hBuALHtDDcOVDABfc5gIefZ2cfRJikD6AGaM
	 +LqQnrXcFUzdTEZ2pteb7LmWITpz0c+RHlhLfXinbRmRD9s3SUdJeT/ofTvk0ldnuZ
	 AEWJjI1/z37n+1m5EHh5ibQoL4MebmU26IgXiPzrQoc294maHbAnFVvjANAagkSQDO
	 buyw1m/5n/fSEm1fe7vK/XWNyUEYKqBQeU2Q83mhnA3GY9VRERWLa6KhvonBM+PL1p
	 SyaonGwCLPYZf40VRB9qe3tAFaInpzavsJ/vz7EqlcA9P1YDQzqKJzyPF30APEbt1F
	 jshX15C98Nqwg==
Date: Thu, 7 Dec 2023 10:06:25 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 006/115] pwm: cros-ec: Change prototype of helpers to
 prepare further changes
Message-ID: <ZXEooV_6xZJpLbJg@google.com>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <c66007e1ef898940f115d2a71f57f153756b9b70.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c66007e1ef898940f115d2a71f57f153756b9b70.1701860672.git.u.kleine-koenig@pengutronix.de>

On Wed, Dec 06, 2023 at 12:43:20PM +0100, Uwe Kleine-König wrote:
> pwm_chip allocation and registration is about to change. For that the
> number of PWM devices must be known earlier in cros_ec_pwm_probe(). So
> make cros_ec_pwm_get_duty() and cros_ec_num_pwms() independent of
> struct cros_ec_pwm_device which is only available later.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

