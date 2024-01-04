Return-Path: <linux-pwm+bounces-669-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3F824A69
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jan 2024 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB12860C8
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jan 2024 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C42C843;
	Thu,  4 Jan 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuOeNjzs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4D2C6B4;
	Thu,  4 Jan 2024 21:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A171BC433C8;
	Thu,  4 Jan 2024 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704404309;
	bh=C6yj4tbn318pdlPF1SHSET3ntYVv+Yq1nuht+eVikeI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GuOeNjzs7+jgEt/pSJNL8/o+eEmnqEjgSzbeDRPDlU7FLeASwA+SiFBaysdcbiZJ2
	 oIs1QY1xa6xwzCiZvoDpPPNrQAZiIF78RafagJ0OaM2wSk1l0EMMm18E+dwxtlN5PF
	 KN5rububvg9JxwK/ZI+MjS2km+QxoA4aVLObgF4oMHTVC0k2PEtFZIZ3wnAddIrhbP
	 u2tkAZgpXu/JhSdZOPxGO7p8BCGozWbnvTM3WmiFzJFoqj/iZjVQfvtE4hyW0EghRn
	 rnZ9UBXxysu8fyq1HAgTvzqJOaJYByyUQuJNvBymlSKv/+3UA72iDXhXHT93R1Kucu
	 4YR4FwLcQHNVQ==
Message-ID: <c1effbda6f323aa58935e1990ba3aed8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <g5ahts576gcub7iwn3xsaky3yu7cqdh3szu67ovixmrrci7zq6@t5fjhj6as5vk>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de> <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de> <5391068cdc86b6117920d31a524d934b.sboyd@kernel.org> <3fhgutm42b6sy6gdydcvflnsjuc2ozjetjbeyoxjvnl2t5q7za@4og2x6gqz5y2> <g5ahts576gcub7iwn3xsaky3yu7cqdh3szu67ovixmrrci7zq6@t5fjhj6as5vk>
Subject: Re: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pwm@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <mripard@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Michal Simek <michal.simek@amd.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 04 Jan 2024 13:38:27 -0800
User-Agent: alot/0.10

Quoting Uwe Kleine-K=C3=B6nig (2024-01-04 10:06:29)
> Hello Stephen,
>=20
> On Mon, Dec 18, 2023 at 02:01:41PM +0100, Uwe Kleine-K=EF=BF=BDnig wrote:
> > [Cc +=3D Maxime]
> >=20
> > Hello Stephen,
> >=20
> > On Sun, Dec 17, 2023 at 04:17:41PM -0800, Stephen Boyd wrote:
> > > Quoting Uwe Kleine-K=EF=BF=BDnig (2023-12-12 10:09:42)
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index af2011c2a93b..78249ca2341c 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -937,6 +937,21 @@ void clk_rate_exclusive_get(struct clk *clk)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> > > > =20
> > > > +static void devm_clk_rate_exclusive_put(void *data)
> > > > +{
> > > > +       struct clk *clk =3D data;
> > > > +
> > > > +       clk_rate_exclusive_put(clk);
> > > > +}
> > > > +
> > > > +int devm_clk_rate_exclusive_get(struct device *dev, struct clk *cl=
k)
> > > > +{
> > > > +       clk_rate_exclusive_get(clk);
> > >=20
> > > It seems the other thread wants this to return an error value.
> >=20
> > The status quo is that clk_rate_exclusive_get() always returns zero.
> > Some users do error handling (which is dead code until Maxime reworks
> > the call that it might return something non-zero), others just call it
> > without checking.
> >=20
> > If you don't require to add something like:
> >=20
> >       ret =3D clk_rate_exclusive_get(clk);
> >       if (ret)
> >               return ret;
> >=20
> > where we currently have just
> >=20
> >       clk_rate_exclusive_get(clk);
> >=20
> > the patch can just be applied (using git am -3) not even hitting a merge
> > conflict without that other series.
>=20
> I wonder what you think about this. This devm_clk_rate_exclusive_get()
> would be very useful and simplify a few more drivers.
>=20
> Do you intend to take the patch as is, or should I rework it to check
> for the zero it returns?
>=20

Please check the return value even if it is always zero. The discussion
about handling the return value can continue in parallel.

