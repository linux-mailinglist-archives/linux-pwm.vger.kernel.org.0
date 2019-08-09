Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FD874E9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406108AbfHIJKu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 05:10:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405991AbfHIJKu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 05:10:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw0v9-0001SL-T6; Fri, 09 Aug 2019 11:10:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw0v9-0005hb-6G; Fri, 09 Aug 2019 11:10:47 +0200
Date:   Fri, 9 Aug 2019 11:10:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Message-ID: <20190809091047.2hrlt245ssjoztfn@pengutronix.de>
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 08, 2019 at 12:55:40PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 08.08.2019 9:38, Yoshihiro Shimoda wrote:
> 
> > Since the rcar_pwm_apply() has already check whehter state->enabled
> 
>    Checked?

and "whether"

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
