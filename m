Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B012943CE5
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 17:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfFMPia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 11:38:30 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:41466 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfFMKFZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 06:05:25 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D4D7F25B813;
        Thu, 13 Jun 2019 20:05:22 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DACF2940483; Thu, 13 Jun 2019 12:05:20 +0200 (CEST)
Date:   Thu, 13 Jun 2019 12:05:20 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] pwm: rcar: Remove suspend/resume support
Message-ID: <20190613100520.26qvkqgb25riztlg@verge.net.au>
References: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559296501-30620-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559296501-30620-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 31, 2019 at 06:55:01PM +0900, Yoshihiro Shimoda wrote:
> According to the Documentation/pwm.txt, all PWM consumers should
> implement power management instead of the PWM driver. So, this
> patch removes suspend/resume support.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

