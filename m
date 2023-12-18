Return-Path: <linux-pwm+bounces-558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC96D8163BF
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 01:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8471A1F21432
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Dec 2023 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C4386;
	Mon, 18 Dec 2023 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpU6fz0F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108A628;
	Mon, 18 Dec 2023 00:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B933C433C8;
	Mon, 18 Dec 2023 00:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702858663;
	bh=z9OCosGjDOKfhXbqagLULkYfua7YeuivqnJCaGuO9r0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WpU6fz0FfanWCqlrXXT2U2Me7Ur4ny3FS0ZPUSJlEJGEznzd4UFuTlaxeuvXVziCm
	 81MoGs0dq4aFBZtOWAiOFhQexLJdZLqYj5Fx2PLsRDy2fQhiXJDhLsn3D5GgFq4whc
	 /HXQmWW1il2tAYjlHaZLsdiAkdSp4lqfw9bB1Hu9Z/m0/Ef5AJMvPRy4wK4n0umpo6
	 8/4hmgb1QGkQ7gdkXayD5zkZkZ+HLinVij88l9X8TqJUPGIWyrMT2VWmpqVuVcXE4P
	 ji69qL/91SSaLP5oz5RRQHiUOsoJ9L6iVip8ISdaN8V/WPX/umHEvq9F5v9/XjQ+QL
	 ImIfsp/BLyooA==
Message-ID: <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de> <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, kernel@pengutronix.de, Sean Anderson <sean.anderson@seco.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 17 Dec 2023 16:17:41 -0800
User-Agent: alot/0.10

Quoting Uwe Kleine-K=C3=B6nig (2023-12-12 10:09:42)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af2011c2a93b..78249ca2341c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -937,6 +937,21 @@ void clk_rate_exclusive_get(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> =20
> +static void devm_clk_rate_exclusive_put(void *data)
> +{
> +       struct clk *clk =3D data;
> +
> +       clk_rate_exclusive_put(clk);
> +}
> +
> +int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
> +{
> +       clk_rate_exclusive_get(clk);

It seems the other thread wants this to return an error value.

> +
> +       return devm_add_action_or_reset(dev, devm_clk_rate_exclusive_put,=
 clk);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_rate_exclusive_get);
> +
>  static void clk_core_unprepare(struct clk_core *core)
>  {
>         lockdep_assert_held(&prepare_lock);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index f88c407925f8..5a749459c3a3 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -199,6 +199,18 @@ bool clk_is_match(const struct clk *p, const struct =
clk *q);
>   */
>  void clk_rate_exclusive_get(struct clk *clk);
> =20
> +/**
> + * devm_clk_rate_exclusive_get - devm variant of clk_rate_exclusive_get
> + * @dev: device the exclusivity is bound to
> + * @clk: clock source
> + *
> + * Calls clk_rate_exclusive_get() on @clk and registers a devm cleanup h=
andler
> + * on @dev to cal clk_rate_exclusive_put().

call

> + *
> + * Must not be called from within atomic context.
> + */
> +int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
> +
>  /**
>   * clk_rate_exclusive_put - release exclusivity over the rate control of=
 a
>   *                          producer

