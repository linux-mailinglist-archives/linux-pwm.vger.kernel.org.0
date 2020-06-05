Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67A81EF028
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFEEHv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 00:07:51 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:40948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgFEEHu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 00:07:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 46926180A9558;
        Fri,  5 Jun 2020 04:07:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:4605:5007:6119:6691:7974:8527:8603:10004:10400:11026:11232:11473:11657:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:12986:13160:13161:13229:13439:14093:14097:14181:14659:14721:21080:21325:21433:21451:21627:30012:30045:30054:30070:30083:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: aunt58_4302bd226d9d
X-Filterd-Recvd-Size: 4478
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jun 2020 04:07:47 +0000 (UTC)
Message-ID: <2f93895709e5837c3b6f38a753057505a9d48ac4.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 04 Jun 2020 21:07:46 -0700
In-Reply-To: <202006041451.19491ECA@keescook>
References: <202006031539.4198EA6@keescook>
         <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
         <202006041451.19491ECA@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 2020-06-04 at 14:52 -0700, Kees Cook wrote:
> On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> > On Wed, 2020-06-03 at 15:40 -0700, Kees Cook wrote:
> > > The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> > > lead to skipping this code.
> > > 
> > > Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/pwm/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 9973c442b455..6b3cbc0490c6 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
> > >  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> > >  		trace_pwm_get(pwm, &pwm->state);
> > >  
> > > -		if (IS_ENABLED(PWM_DEBUG))
> > > +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
> > >  			pwm->last = pwm->state;
> > >  	}
> > >  
> > > -- 
> > > 2.25.1
> > > 
> > 
> > more odd uses (mostly in comments)
> > 
> > $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
> >   sed -r 's/\s+//g'| \
> >   grep -v '(CONFIG_' | \
> >   sort | uniq -c | sort -rn
> >       7 IS_ENABLED(DEBUG)
> >       4 IS_ENABLED(DRM_I915_SELFTEST)
> >       4 IS_ENABLED(cfg)
> >       2 IS_ENABLED(opt_name)
> >       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
> >       2 IS_ENABLED(config)
> >       2 IS_ENABLED(cond)
> >       2 IS_ENABLED(__BIG_ENDIAN)
> >       1 IS_ENABLED(x)
> >       1 IS_ENABLED(STRICT_KERNEL_RWX)
> >       1 IS_ENABLED(PWM_DEBUG)
> >       1 IS_ENABLED(option)
> >       1 IS_ENABLED(ETHTOOL_NETLINK)
> >       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
> >       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
> > 
> > STRICT_KERNEL_RWX is misused here in ppc
> > 
> > ---
> > 
> > Fix pr_warn without newline too.
> > 
> >  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> > index 51e3c15f7aff..dd60c5f2b991 100644
> > --- a/arch/powerpc/mm/book3s64/hash_utils.c
> > +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> > @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
> >  		 * Pick a size for the linear mapping. Currently, we only
> >  		 * support 16M, 1M and 4K which is the default
> >  		 */
> > -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> > +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
> >  		    (unsigned long)_stext % 0x1000000) {
> >  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> > -				pr_warn("Kernel not 16M aligned, "
> > -					"disabling 16M linear map alignment");
> > +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
> >  			aligned = false;
> >  		}
> 
> Joe, I was going to send all of the fixes for these issues, but your
> patch doesn't have a SoB. Shall I add one for the above patch?

<shrug> sure if you want, or submit it yourself.

My feeling about these types of changes is the maintainers
of the subsystems, in this case ppc, should manage this
themselves and shouldn't require anyone else to actually
bother to send real patches.


