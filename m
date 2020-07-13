Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD38221D22D
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2020 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgGMIsq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 04:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMIsp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 13 Jul 2020 04:48:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4A8206F0;
        Mon, 13 Jul 2020 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594630125;
        bh=bUm42OOlUYxKokde8JgZjn2YGEQW40wUc5t4VOAgz6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh/czHuFrGcqbbP/xy+qMZDeX3DFrKVX11BDJRcESXTCIVVZiyEvONwWBUdtnqXmg
         ipBq+kBdsaLG8qCyWIpJyLhHvYnmeXWMoWih9EH16ptOans+JogKX09Vm45LTetKIA
         k0WqM86d8+BaJg4UgWpvVm4oxmH7dlxS+2pZmC3E=
Date:   Mon, 13 Jul 2020 16:48:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Paul Barker <pbarker@konsulko.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
Message-ID: <20200713084839.GG15718@dragon>
References: <20200710051937.20647-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710051937.20647-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 10, 2020 at 07:19:37AM +0200, Uwe Kleine-König wrote:
> The imx-pwm driver supports 3 cells and this is the more flexible setting.
> So use it by default and overwrite it back to two for the files that
> reference the PWMs with just 2 cells to minimize changes.
> 
> This allows to drop explicit setting to 3 cells for the boards that already
> depend on this. The boards that are now using 2 cells explicitly can be
> converted to 3 individually.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thanks.
