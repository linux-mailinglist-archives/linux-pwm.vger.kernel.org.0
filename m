Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45C9B9BA
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfHXAdW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:33:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49793 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfHXAdW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:33:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1JzY-0005eM-12; Sat, 24 Aug 2019 02:33:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1JzX-0000KL-Jf; Sat, 24 Aug 2019 02:33:15 +0200
Date:   Sat, 24 Aug 2019 02:33:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 04/13] pwm: mediatek: allocate the clks array
 dynamically
Message-ID: <20190824003315.i3ocilzg6vf3ft5p@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-5-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566457123-20791-5-git-send-email-sam.shih@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 02:58:34PM +0800, Sam Shih wrote:
> Instead of using fixed size of arrays, allocate the memory for them
> based on the information we get from the DT.
> 
> Also remove the check for num_pwms, due to dynamically allocate pwm
> should not cause array index out of bound.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
