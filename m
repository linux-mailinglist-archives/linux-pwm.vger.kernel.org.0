Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87A67D0F3
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jan 2023 17:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAZQJx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Jan 2023 11:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjAZQJt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Jan 2023 11:09:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21B4E508;
        Thu, 26 Jan 2023 08:09:48 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B3E8D6602E7A;
        Thu, 26 Jan 2023 16:09:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674749386;
        bh=ReNx+z5pm2gVgqa0p7qKV5inYrk0tRsLDHNGin5UdgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+i/l6p/S0iieHzfPbRkG8LrtfwHriyYIr33/wuK0q1ebLkHb9HvtMJaWrm8QSRm2
         sbHtgH6/deLDvQU7YvssI4gekzf/PW8HGppFUrxrGLRGhEobwk8KDqc+bRxHCVatmS
         /IJGrXHzohYPF67EbnrBGs1peqrqGBYud/pJMI0r12azrf2FZI13NyLlo5bl8GG+GE
         E+y8d4TmKrlTtXMadbYcjsdA3+PJcR6tdcNZW6ZYyi0JdbrflCA/jGhRTfX3LTrXgP
         qXP/qT/zL865I+ZXhVEGMMKzG0LqbDr0kR3HiyyzBa7/fEvx9hjfSYyrgf6rrZ+2Cn
         +pWHHPGx4JSuA==
Date:   Thu, 26 Jan 2023 11:09:27 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com, weiqing.kong@mediatek.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/2] pwm: mtk-disp: Configure double buffering before
 reading in .get_state()
Message-ID: <20230126160927.4hgifpmybvsgshro@notapiano>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <20230123160615.375969-3-angelogioacchino.delregno@collabora.com>
 <20230126151914.rhwhioz6yyhaq3z2@notapiano>
 <aa17fa46-0f16-2102-1bd3-6d76cee90ee1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa17fa46-0f16-2102-1bd3-6d76cee90ee1@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jan 26, 2023 at 04:24:29PM +0100, AngeloGioacchino Del Regno wrote:
> Il 26/01/23 16:19, N�colas F. R. A. Prado ha scritto:
> > On Mon, Jan 23, 2023 at 05:06:15PM +0100, AngeloGioacchino Del Regno wrote:
> > > The DISP_PWM controller's default behavior is to always use register
> > > double buffering: all reads/writes are then performed on shadow
> > > registers instead of working registers and this becomes an issue
> > > in case our chosen configuration in Linux is different from the
> > > default (or from the one that was pre-applied by the bootloader).
> > > 
> > > An example of broken behavior is when the controller is configured
> > > to use shadow registers, but this driver wants to configure it
> > > otherwise: what happens is that the .get_state() callback is called
> > > right after registering the pwmchip and checks whether the PWM is
> > > enabled by reading the DISP_PWM_EN register;
> > > At this point, if shadow registers are enabled but their content
> > > was not committed before booting Linux, we are *not* reading the
> > > current PWM enablement status, leading to the kernel knowing that
> > > the hardware is actually enabled when, in reality, it's not.
> > > 
> > > The aforementioned issue emerged since this driver was fixed with
> > > commit 0b5ef3429d8f ("pwm: mtk-disp: Fix the parameters calculated
> > > by the enabled flag of disp_pwm") making it to read the enablement
> > > status from the right register.
> > > 
> > > Configure the controller in the .get_state() callback to avoid
> > > this desync issue and get the backlight properly working again.
> > > 
> > > Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/pwm/pwm-mtk-disp.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> > > index 82b430d881a2..fe9593f968ee 100644
> > > --- a/drivers/pwm/pwm-mtk-disp.c
> > > +++ b/drivers/pwm/pwm-mtk-disp.c
> > > @@ -196,6 +196,16 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
> > >   		return err;
> > >   	}
> > > +	/*
> > > +	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
> > > +	 * registers double buffer and manual commit to working register before
> > > +	 * performing any read/write operation
> > > +	 */
> > > +	if (mdp->data->bls_debug)
> > 
> > I feel like this condition should be the same as in the apply() callback, since
> > they're doing the same write operation, so also have '&& !has_commit'.
> > 
> 
> The bls_debug register is used to both enable and/or disable various features,
> including the one that I'm targeting in this commit, which is disabling shadow
> registers.
> 
> As I explained in the commit message, we don't want to - and cannot - assume that
> the bootloader doesn't *reset* the backlight controller before booting Linux: a
> reset would re-enable the shadow registers, and this function being called as
> first to check the backlight EN status may fail to do so.
> 
> This is as well true in the opposite situation where, in the future, we may want
> to set shadow registers ON, while the bootloader sets them OFF before booting:
> adding a (x && !has_commit) check in this branch would defeat that purpose and
> make this commit... well.. partially broken! :-)

Makes sense, but in that case shouldn't we drop the (&& !has_commit) in the
check of the previous commit too? I get that in the pwm's core current logic,
get_state() is run before apply(), but given that we also write the debug
register in apply(), we're not relying on that. So as it currently stands, if in
the future the bootloader sets shadow registers OFF, and we want to set them ON,
and we call apply() before having called get_state(), we'd be back to the broken
behavior.

Thanks,
N�colas

> 
> Cheers!
> Angelo
> 
> > Reviewed-by: N�colas F. R. A. Prado <nfraprado@collabora.com>
> > Tested-by: N�colas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > On MT8192 Asurada Spherion.
> > 
> > Thanks,
> > N�colas
> > 
> > > +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> > > +					 mdp->data->bls_debug_mask,
> > > +					 mdp->data->bls_debug_mask);
> > > +
> > >   	rate = clk_get_rate(mdp->clk_main);
> > >   	con0 = readl(mdp->base + mdp->data->con0);
> > >   	con1 = readl(mdp->base + mdp->data->con1);
> > > -- 
> > > 2.39.0
> > > 
> > > 
> 
> 
